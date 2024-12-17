import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/authentication/domain/params/login_params.dart';
import 'package:mra/src/components/loader/loader.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/components/will_pop/will_pop.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends ConsumerStatefulWidget {
  final OtpArgs args;
  const OTPScreen({super.key, required this.args});

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return WillPop(
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ColSpacing(
                  40.h,
                ),
                InkWell(
                  onTap: () => context.pop(),
                  child: SvgPicture.asset(
                    kBackIconSvg,
                    colorFilter:
                        const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),
                  ),
                ),
                ColSpacing(
                  40.h,
                ),
                Text(
                  'We’ve Sent an SMS to your number',
                  style: theme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ColSpacing(
                  16.h,
                ),
                Text(
                  'It contains six digits - please enter them below',
                  style: theme.bodyMedium,
                ),
                ColSpacing(
                  96.h,
                ),
                Center(
                  child: Pinput(
                    defaultPinTheme: PinTheme(
                      width: 48,
                      textStyle: theme.bodyMedium?.copyWith(fontSize: 28.sp),
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                        border: Border(
                          bottom: BorderSide(color: kGray2Color),
                        ),
                      ),
                    ),
                    onSubmitted: validateOtp,
                    onCompleted: validateOtp,
                    autofocus: true,
                    length: 6,
                    controller: _textEditingController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                ColSpacing(
                  56.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn\'t get an SMS? ',
                      style: theme.bodyLarge,
                    ),
                    InkWell(
                      onTap: sendOtp,
                      child: Text(
                        'Resend OTP',
                        style: theme.bodyLarge?.copyWith(
                            color: kPrimaryColor, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        backgroundColor: kWhiteColor,
      ),
    );
  }

  void sendOtp() async {
    Loader.show(context);
    final result =
        await ref.read(authRepoProvider).requestOTP(widget.args.phoneNumber);
    result.when(
      success: (id) => Toast.success("OTP sent successfully", context),
      apiFailure: (fail, _) => Toast.apiError(fail, context),
    );
    Loader.hide();
  }

  void validateOtp(String otp) async {
    Loader.show(context);
    final result = await ref
        .read(userStateProvider.notifier)
        .verifyOtp(widget.args.phoneNumber, otp);
    result.when(
      success: (token) => login(token),
      apiFailure: (fail, code) => Toast.apiError(fail, context),
    );
    Loader.hide();
  }

  Future<void> login(String token) async {
    final response = await ref.read(userStateProvider.notifier).login(
          LoginParams(authToken: token, phoneNumber: widget.args.phoneNumber),
        );
    response.when(
      success: (_) {},
      apiFailure: (fail, _) => Toast.apiError(fail, context),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}

class OtpArgs {
  final String phoneNumber;

  OtpArgs(this.phoneNumber);
}
