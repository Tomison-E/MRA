import 'package:mra/app/access_control/data/models/guest.dart';
import 'package:mra/app/access_control/domain/params/guest_update_params.dart';
import 'package:mra/app/access_control/presentation/logic/states/guest_state.dart';
import 'package:mra/app/access_control/presentation/logic/states/guest_verification_state.dart';
import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/src/components/loader/loader.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuestCard extends ConsumerWidget {
  final String code;
  final Guest guest;
  final VoidCallback clear;
  const GuestCard(this.code, this.guest, this.clear, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 112,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Name"),
                  ColSpacing(16),
                  Text("Number"),
                  ColSpacing(16),
                  Text("code")
                ],
              ),
              const RowSpacing(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(guest.name),
                  const ColSpacing(16),
                  Text(guest.phoneNumber),
                  const ColSpacing(16),
                  Text(code)
                ],
              ),
              const Spacer(),
              TextButton(
                onPressed: () => dialog(context, ref),
                style: TextButton.styleFrom(
                    alignment: Alignment.bottomRight, padding: EdgeInsets.zero),
                child: Text(label),
              )
            ],
          ),
        ),
      ),
    );
  }

  String get label {
    switch (guest.status) {
      case GuestStatus.checkedOut: //todo no check out
        return "";
      case GuestStatus.checkedIn:
        return "Check Out";
      case GuestStatus.pending:
        return 'Check In';
    }
  }

  GuestStatus get updatedStatus {
    switch (guest.status) {
      case GuestStatus.checkedOut:
        return GuestStatus.pending;
      case GuestStatus.checkedIn:
        return GuestStatus.checkedOut;
      case GuestStatus.pending:
        return GuestStatus.checkedIn;
    }
  }

  VoidCallback action(BuildContext context, WidgetRef ref) {
    switch (guest.status) {
      case GuestStatus.checkedOut:
        return () {};
      case GuestStatus.checkedIn:
      case GuestStatus.pending:
        return () async {
          Navigator.pop(context);
          Loader.show(context);
          final response = await ref
              .read(guestVerificationStateProvider(code).notifier)
              .updateGuest(GuestUpdateParams(
                  guest.id, ref.read(userStateProvider)!.id, updatedStatus));
          Loader.hide();
          response.when(
              success: (_) {
                Toast.success("success", context);
                clear();
                ref.invalidate(guestHistoryProvider);
              },
              apiFailure: (fail, _) => Toast.apiError(fail, context));
        };
    }
  }

  void dialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext contxt) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          title: Text('You\'re about to ${label.toLowerCase()} $code'),
          content: const Text('Are you sure?'),
          actionsAlignment: MainAxisAlignment.end,
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(contxt).pop();
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
