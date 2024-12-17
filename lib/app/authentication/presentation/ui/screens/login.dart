/*
import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/authentication/domain/params/login_params.dart';
import 'package:mra/src/components/buttons/buttons.dart';
import 'package:mra/src/components/loader/loader.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/text_fields/phone_number_field.dart';
import 'package:mra/src/components/text_fields/text_fields.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:mra/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              ColSpacing(120.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Login to your DEMS\naccount',
                  style: theme.headlineSmall,
                ),
              ),
              ColSpacing(
                16.h,
              ),
              Row(
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: theme.bodyLarge,
                  ),
                  InkWell(
                    onTap: () => context.goNamed(kVerifyDetailsRoute),
                    child: Text(
                      'Create an account',
                      style: theme.bodyLarge?.copyWith(
                          color: kPrimaryColor, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              ColSpacing(
                56.h,
              ),
              const LoginForm(),
              //FORGOT PASSWORD
             */
/* Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Divider()),
                    Text(
                      ' or ',
                    ),
                    Expanded(child: Divider())
                  ],
                ),
              ),*//*

              //SOCIAL LOGIN
           */
/*   Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SocialLoginButton(
                    iconPath: kGoogleSvg,
                    actionText: 'Sign in with Google',
                    onTap: () {},
                  ),
                  SocialLoginButton(
                    iconPath: kAppleSvg,
                    actionText: 'Sign in with Apple',
                    onTap: () {},
                  ),
                ],
              )*//*

            ],
          ),

      ),
    );
  }
}

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LoginForm();
  }
}

class _LoginForm extends ConsumerState<LoginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginParams params = LoginParams();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: _autoValidate,
      child: Column(
        children: [
          CustomFormField(
            label: 'Phone Number',
            textField: CustomPhoneNumberTextField(
              validator: Validators.verifyInput,
              onSubmit: (value) => params.phoneNumber = value!,
            ),
          ),
          ColSpacing(8.h),
          CustomFormField(
            label: 'Password',
            textField: CustomPasswordTextField(
              validator: (input) => Validators.verifyPassword(input),
              onSubmit: (value) => params.passcode = value!,
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomTextButton(
              buttonText: 'Forgot Password?',
              onPressed: () {},
            ),
          ),
          ColSpacing(
            54.h,
          ),
          // LOGIN BUTTON
          CustomFilledButton(
            onPressed: onSubmitted,
            buttonText: 'Login',
          ),
        ],
      ),
    );
  }

  Future<void> onSubmitted() async {
    final FormState form = _formKey.currentState!;
    form.save();
    if (form.validate()) {
      Loader.show(context);
      final response = await ref.read(userStateProvider.notifier).login(params);
      Loader.hide();
      response.when(
          success: (_) {},
          apiFailure: (fail, _) => Toast.apiError(fail, context));
    } else {
      _autoValidate = AutovalidateMode.always;
      Toast.formError(context);
    }
  }

  void reset(FormState form) {
    form.reset();
  }
}
*/
