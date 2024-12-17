import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/text_fields/form_field.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../src/res/assets/svgs/svgs.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final phoneNumber = TextEditingController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(kBackIconSvg),
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              ColSpacing(24.h),
              SvgPicture.asset(kUserSecuritySvg,width: 248,),
              Text(
                'Reset Password',
                style: theme.titleLarge,
              ),
              ColSpacing(16.h),
              Text(
                'Enter the phone number you signed up with below and we’ll send you a code to help you reset your password',
                style:
                    theme.bodyLarge?.copyWith(fontSize: 14.sp, height: 1.6.h),
                textAlign: TextAlign.center,
              ),
              ColSpacing(40.h),
              CustomFormField(
                  label: 'Phone Number',
                  textField: TextFormField(
                    cursorColor: k585666,
                    controller: phoneNumber,
                  )),
              ColSpacing(80.h),
              FilledButton(
                  onPressed: () {}, child: const Text('Send reset code'))
            ],
          )),
    );
  }
}
