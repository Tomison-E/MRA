import 'package:mra/app/alert/data/models/incident.dart';
import 'package:mra/app/alert/domain/params/incident_params.dart';
import 'package:mra/app/alert/domain/use_cases/use_cases.dart';
import 'package:mra/app/alert/presentation/ui/modals/alert_sent.dart';
import 'package:mra/app/alert/presentation/ui/widgets/incident_dropdown.dart';
import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/src/components/loader/loader.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/text_fields/form_field.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertReport extends ConsumerStatefulWidget {
  const AlertReport({super.key});

  @override
  ConsumerState<AlertReport> createState() => _AlertState();
}

class _AlertState extends ConsumerState<AlertReport> {
  IncidentType? _incidentType;
  final TextEditingController _editingController = TextEditingController();

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          ColSpacing(40.h),
          CustomFormField(
            label: 'Incident Type',
            textField: SizedBox(
              width: 396.w,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(8.r)),
                child: IncidentDropdownButton(
                  onChanged: (type) {
                    _incidentType = type;
                  },
                ),
              ),
            ),
          ),
          ColSpacing(32.h),
          CustomFormField(
            label: 'Describe incident',
            textField: TextFormField(
              minLines: 12,
              maxLines: 15,
              controller: _editingController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                  fillColor: kWhiteColor, contentPadding: EdgeInsets.all(8)),
            ),
          ),
          ColSpacing(32.h),
          FilledButton(
            onPressed: sendAlert,
            style: FilledButton.styleFrom(backgroundColor: kErrorText),
            child: const Text('Alert Security'),
          )
        ],
      ),
    );
  }

  void sendAlert() async {
    if (_incidentType == null) {
      Toast.error("kindly select incident type", context);
      return;
    }
    if (_editingController.text.isEmpty) {
      Toast.error("kindly input a description of the incident", context);
      return;
    }
    Loader.show(context);
    final response = await ref.read(sendAlertUseCaseProvider(IncidentParams(
        _incidentType!,
        _editingController.text,
        ref.read(userStateProvider)!.houseHold.householdId)));
    Loader.hide();
    response.when(
        success: (_) => AlertSentModal.showSentDialog(context),
        apiFailure: (err, _) => Toast.apiError(err, context));
  }
}
