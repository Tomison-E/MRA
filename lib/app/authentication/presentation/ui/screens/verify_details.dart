import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/authentication/data/models/locale.dart';
import 'package:mra/app/authentication/presentation/ui/screens/otp.dart';
import 'package:mra/src/components/buttons/buttons.dart';
import 'package:mra/src/components/flexible_constrained_box.dart';
import 'package:mra/src/components/loader/loader.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/text_fields/phone_number_field.dart';
import 'package:mra/src/components/text_fields/text_fields.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/components/will_pop/will_pop.dart';
import 'package:mra/src/extensions/strings.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:mra/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class VerifyDetailsScreen extends ConsumerStatefulWidget {
  const VerifyDetailsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _VerifyDetails();
  }
}

class _VerifyDetails extends ConsumerState<VerifyDetailsScreen> {
  final _phoneController = TextEditingController();
  final locale = const UserLocale.ng();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return WillPop(
      child: Scaffold(
        backgroundColor: kWhiteColor,
        body: FlexibleConstrainedBox(
          minHeight: 510,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 100.h),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Create your DEMS\naccount',
                    style: theme.headlineSmall,
                  ),
                ),
                ColSpacing(
                  16.h,
                ),
   /*             Row(
                  children: [
                    Text(
                      'Already have an account? ',
                      style: theme.bodyLarge,
                    ),
                    InkWell(
                      onTap: () => context.goNamed(kLoginRoute),
                      child: Text(
                        'Log In',
                        style: theme.bodyLarge?.copyWith(
                            color: kPrimaryColor, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),*/
                ColSpacing(
                  56.h,
                ),
                Text(
                  'Input the phone number that was sent to the estate manager to create an account.',
                  style: theme.bodyLarge,
                ),
                ColSpacing(
                  24.h,
                ),
                CustomFormField(
                  label: 'Phone Number',
                  textField: CustomPhoneNumberTextField(
                    textController: _phoneController,
                  ),
                ),
                const Spacer(),
                CustomFilledButton(
                  onPressed: sendOtp,
                  buttonText: 'Verify Details',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendOtp() async {
    final intlNumber = await _phoneController.text.getInternationalPhoneNumber(locale);
    if (mounted) {
      if (intlNumber == null) {
        Toast.error("Invalid Number", context);
        return;
      }
      Loader.show(context);
      final result =
          await ref.read(authRepoProvider).requestOTP(intlNumber);
      result.when(
        success: (_) => context.pushNamed(
          kOTPRoute,
          extra: OtpArgs(intlNumber),
        ),
        apiFailure: (fail, code){
          if(code == 404) {
            Toast.error("This phone number is not recognized", context);
          } else {
            Toast.apiError(fail, context);
          }
        },
      );
      Loader.hide();
    }
  }
}
