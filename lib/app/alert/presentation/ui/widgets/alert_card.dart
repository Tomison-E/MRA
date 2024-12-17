import 'package:mra/app/alert/data/models/alert.dart';
import 'package:mra/app/alert/data/models/incident.dart';
import 'package:mra/app/alert/domain/params/alert_history_params.dart';
import 'package:mra/app/alert/presentation/logic/states/active_alert_state.dart';
import 'package:mra/app/alert/presentation/logic/states/inactive_alert_state.dart';
import 'package:mra/app/alert/presentation/ui/widgets/alert_history.dart';
import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/src/components/loader/loader.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class AlertCard extends ConsumerWidget {
  const AlertCard(this.alert, this.type, this.params, {super.key});
  final AlertHistoryType type;
  final Alert alert;
  final AlertHistoryParams params;

  @override
  Widget build(BuildContext context, ref) {
    final textTheme = Theme.of(context).textTheme;
    final user = ref.watch(userStateProvider)!;
    final isResident = user.isResident;
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(alert.type.iconPath),
                  const RowSpacing(8),
                  Text(alert.type.capsName)
                ],
              ),
              const ColSpacing(16),
              Text(alert.description, style: textTheme.bodyMedium),
              if (isResident) ...[
                const ColSpacing(10),
                Text(
                  alert.status.name,
                  style: textTheme.bodyLarge?.copyWith(color: kBlueColor),
                )
              ] else ...[
                const ColSpacing(32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("household"), //todo
                    TextButton(
                        onPressed: () => dialog(context, ref),
                        child: Text(label))
                  ],
                )
              ]
            ],
          ),
        ),
      ),
    );
  }

  String get label {
    switch (type) {
      case AlertHistoryType.all:
        return "Responded";
      case AlertHistoryType.active:
        return "Close";
      case AlertHistoryType.unResponded:
        return "Respond";
    }
  }

  VoidCallback action(BuildContext context, WidgetRef ref) {
    switch (type) {
      case AlertHistoryType.all:
        return () {};
      case AlertHistoryType.active:
        return () async {
          Navigator.pop(context);
          Loader.show(context);
          final response = await ref
              .read(activeAlertStateProvider(params).notifier)
              .closeAlert(alert.id);
          Loader.hide();
          response.when(
              success: (_) => Toast.success("success", context),
              apiFailure: (fail, _) => Toast.apiError(fail, context));
        };
      case AlertHistoryType.unResponded:
        return () async {
          Navigator.pop(context);
          Loader.show(context);
          final response = await ref
              .read(inactiveAlertStateProvider(params).notifier)
              .respondToAlert(alert.id);
          Loader.hide();
          response.when(
              success: (_) => Toast.success("success", context),
              apiFailure: (fail, _) => Toast.apiError(fail, context));
        };
    }
  }

  void dialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('In respect to this alert, You\'re about to $label'),
          content: const Text('Are you sure?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: action(context, ref),
              child: Text(label),
            ),
          ],
          actionsPadding: const EdgeInsets.symmetric(horizontal: 60),
        );
      },
    );
  }
}
