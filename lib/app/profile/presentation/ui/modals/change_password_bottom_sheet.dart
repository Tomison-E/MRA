import 'package:mra/src/components/buttons/filled_button.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/text_fields/form_field.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordBottomSheet extends ConsumerStatefulWidget {
  const ChangePasswordBottomSheet({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordSheet();

  static void displayModal(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: kWhiteColor,
      useRootNavigator: true,
      constraints: BoxConstraints.tightFor(height: 600.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) => const ChangePasswordBottomSheet(),
    );
  }
}

class _ChangePasswordSheet extends ConsumerState {
  final AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    oldPassword.dispose();
    newPassword.dispose();
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
                Padding(
                  padding: EdgeInsets.only(top: 32.h, bottom: 48.h),
                  child:  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Change Password',style: theme.labelLarge,),
                  ),
                ),
                CustomFormField(
                  label: 'Old Password',
                  textField: TextFormField(
                    cursorColor: k585666,
                    controller: oldPassword,
                  ),
                ),
                CustomFormField(
                    label: 'New Password',
                    textField: TextFormField(
                      cursorColor: k585666,
                      controller: newPassword,
                    )),
                ColSpacing(
                  80.h,
                ),
                CustomFilledButton(
                  onPressed: () {},
                  buttonText: 'Change Password',
                ),
                ColSpacing(40.h),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Can\'t remember password?  ',
                      style: theme.bodyLarge,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        context.pushNamed(kResetPasswordRoute);},
                      child: Text(
                        'Reset password',
                        style: theme.bodyLarge?.copyWith(
                            color: kPrimaryColor, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
