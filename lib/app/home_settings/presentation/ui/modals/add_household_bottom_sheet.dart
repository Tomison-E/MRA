import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/app/home_settings/data/models/personnel.dart';
import 'package:mra/app/home_settings/domain/params/personnel_params.dart';
import 'package:mra/app/home_settings/home_settings_providers.dart';
import 'package:mra/src/components/buttons/filled_button.dart';
import 'package:mra/src/components/loader/loader.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/text_fields/form_field.dart';
import 'package:mra/src/components/text_fields/phone_number_field.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/components/will_pop/will_pop.dart';
import 'package:mra/src/extensions/strings.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddHouseholdBottomSheet extends ConsumerStatefulWidget {
  final PersonnelType type;

  const AddHouseholdBottomSheet({super.key, required this.type});

  @override
  ConsumerState<AddHouseholdBottomSheet> createState() =>
      _AddHouseholdBottomSheetState();

  static void displayModal(BuildContext context,
      {required PersonnelType type}) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: kWhiteColor,
      useRootNavigator: true,
      constraints: BoxConstraints.tightFor(height: 582.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) => AddHouseholdBottomSheet(
        type: type,
      ),
    );
  }
}

class _AddHouseholdBottomSheetState
    extends ConsumerState<AddHouseholdBottomSheet> {
  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController phone = TextEditingController();

  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  late final User userState = ref.read(userStateProvider)!;
  late final String houseId = userState.houseHold.householdId;

  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return WillPop(
      child: Form(
        key: _formKey,
        autovalidateMode: _autoValidateMode,
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
            ),
            child: Column(
              children: [
                ColSpacing(
                  32.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Add ${widget.type.name}',
                    style: theme.headlineSmall,
                  ),
                ),
                ColSpacing(
                  40.h,
                ),
                CustomFormField(
                  label: 'First Name',
                  textField: TextFormField(
                    controller: firstName,
                    cursorColor: k585666,
                    validator: Validators.verifyInput,
                  ),
                ),
                CustomFormField(
                  label: 'Last Name',
                  textField: TextFormField(
                    controller: lastName,
                    cursorColor: k585666,
                    validator: Validators.verifyInput,
                  ),
                ),
                CustomFormField(
                  label: 'Phone Number',
                  textField: CustomPhoneNumberTextField(
                    textController: phone,
                    validator: Validators.verifyInput,
                  ),
                ),
                ColSpacing(
                  32.h,
                ),
                //this button should be disabled if formField is not validated
                CustomFilledButton(
                  onPressed: () {
                    onSubmitted();
                  },
                  buttonText: 'Add ${widget.type.name}',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> onSubmitted() async {
    final FormState form = _formKey.currentState!;
    form.save();
    if (form.validate()) {
      final isValidPhone = await phone.text.getInternationalPhoneNumber(userState.locale);
      if (mounted) {
        if (isValidPhone != null) {
          Toast.error(isValidPhone, context);
          return;
        }
        addMembers(PersonnelParams(
            firstName.text, lastName.text, phone.text, houseId, widget.type));
      }
    } else {
      _autoValidateMode = AutovalidateMode.always;
      Toast.formError(context);
    }
  }

  void addMembers(PersonnelParams params) async {
    Loader.show(context);
    final response =
        await ref.read(houseHoldStateProvider.notifier).createPersonnel(params);
    Loader.hide();
    response.when(
        success: (_) {
          Toast.success("${params.type.name} added successfully", context);
          Navigator.pop(context);
        },
        apiFailure: (err, _) => Toast.apiError(err, context));
  }

  @override
  void dispose() {
    super.dispose();
    firstName.dispose();
    lastName.dispose();
    phone.dispose();
  }
}
