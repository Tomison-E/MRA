import 'package:mra/app/profile/presentation/ui/modals/change_password_bottom_sheet.dart';
import 'package:mra/src/components/buttons/buttons.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/text_fields/form_field.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecurityTabView extends StatelessWidget {
  const SecurityTabView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          ColSpacing(32.h),
          CustomFormField(
            label: 'Password',
            textField: CustomFilledButton(
              onPressed: () {
                ChangePasswordBottomSheet.displayModal(context);
              },
              style: FilledButton.styleFrom(
                  backgroundColor: kE9F5FF,
                  foregroundColor: kPrimaryColor,
                  textStyle:
                      theme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
              buttonText: 'Change Password',
            ),
          ),
         /* SocialLoginButton(
            iconPath: kGoogleSvg,
            actionText: 'Enable Sign in with Google',
            onTap: () {},
            textAlignment: MainAxisAlignment.center,
          ),
          ColSpacing(24.h),
          SocialLoginButton(
            iconPath: kAppleSvg,
            actionText: 'Enable Sign in with Apple',
            onTap: () {
            },
            textAlignment: MainAxisAlignment.center,
          ),*/
        ],
      ),
    );
  }
}
