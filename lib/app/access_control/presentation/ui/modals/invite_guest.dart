import 'package:mra/app/access_control/domain/params/guest_params.dart';
import 'package:mra/app/access_control/presentation/logic/states/guest_state.dart';
import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/src/components/buttons/buttons.dart';
import 'package:mra/src/components/loader/loader.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/text_fields/form_field.dart';
import 'package:mra/src/components/text_fields/phone_number_field.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/extensions/strings.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InviteGuestBottomSheet extends ConsumerStatefulWidget {
  const InviteGuestBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _InviteGuestSheet();
  }

  static void displayModal(BuildContext context) async {
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
      builder: (context) => const InviteGuestBottomSheet(),
    );
  }
}

class _InviteGuestSheet extends ConsumerState {
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final TextEditingController name = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    phone.dispose();
    name.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidateMode,
            child: Column(
              children: [
                ColSpacing(
                  32.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Invite Guest',
                    style: theme.headlineSmall,
                  ),
                ),
                ColSpacing(
                  40.h,
                ),
                CustomFormField(
                  label: 'Guest Name',
                  textField: TextFormField(
                    cursorColor: k585666,
                    controller: name,
                    validator: Validators.verifyInput,
                  ),
                ),
                CustomFormField(
                  label: 'Guest Phone Number',
                  textField: CustomPhoneNumberTextField(
                    textController: phone,
                    validator: Validators.verifyInput,
                  ),
                ),
                ColSpacing(
                  145.h,
                ),
                //this button should be disabled if formField is not validated
                CustomFilledButton(
                  onPressed: () {
                    onSubmitted();
                  },
                  buttonText: 'Send Invite',
                ),
              ],
            ),
          )),
    );
  }

  Future<void> onSubmitted() async {
    final FormState form = _formKey.currentState!;
    form.save();
    if (form.validate()) {
      final user = ref.read(userStateProvider)!;
      final isValidPhone = await phone.text.getInternationalPhoneNumber(user.locale);
      if (mounted) {
        if (isValidPhone != null) {
          if (mounted) {
            Toast.error(isValidPhone, context);
            return;
          }
        }
        inviteGuest(
            GuestParams(user.houseHold.householdId, name.text, phone.text));
      }
    } else {
      _autoValidateMode = AutovalidateMode.always;
      Toast.formError(context);
    }
  }

  void inviteGuest(GuestParams guest) async {
    Loader.show(context);
    final response =
        await ref.read(guestStateProvider.notifier).inviteGuest(guest);
    Loader.hide();
    response.when(
        success: (_) {
          Toast.success("${guest.name} has been invited", context);
          Navigator.pop(context);
        },
        apiFailure: (err, _) => Toast.apiError(err, context));
  }
}
