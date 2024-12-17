/*
import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/src/components/loader/loader.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/components/will_pop/will_pop.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OTPScreen extends ConsumerStatefulWidget {
  final OtpArgs args;
  const OTPScreen({Key? key, required this.args}) : super(key: key);

  @override
  ConsumerState<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends ConsumerState<OTPScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  AnimationController? _animationController;
  int levelClock = 2 * 60;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: levelClock),
    );

    _animationController!.forward();
    _listenSmsCode();
    super.initState();
  }

  _listenSmsCode() async {
    await SmsAutoFill().listenForCode();
  }

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
                    child: SvgPicture.asset(kBackIconSvg)),
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
                  child: PinFieldAutoFill(
                    onCodeSubmitted: validateOtp,
                    autoFocus: true,
                    keyboardType: const TextInputType.numberWithOptions(),
                    codeLength: 5,
                    controller: _textEditingController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: UnderlineDecoration(
                      lineHeight: 2,
                      lineStrokeCap: StrokeCap.square,
                      colorBuilder: const FixedColorBuilder(Colors.transparent),
                    ),
                  ),
                ),
                */
/*    Center(
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
                ),*//*

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
                    const Spacer(),
                    Countdown(
                      animation: StepTween(
                        begin: levelClock, // THIS IS A USER ENTERED NUMBER
                        end: 0,
                      ).animate(_animationController!),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        backgroundColor: kWhiteColor,
      ),
    );
  }

  void validateOtp(String otp) async {
    Loader.show(context);
    final result = await ref
        .read(userStateProvider.notifier)
        .verifyOtp(widget.args.phoneNumber, otp, widget.args.uid);
    result.when(
      success: (_) => context.pushNamed(kCreateAccountRoute,
          extra: widget.args.phoneNumber),
      apiFailure: (fail, code) {
        if (code == 409) {
          context.goNamed(kLoginRoute);
          Toast.info("User is already verified", context);
        } else {
          Toast.apiError(fail, context);
        }
      },
    );
    Loader.hide();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    SmsAutoFill().unregisterListener();
    _animationController!.dispose();
    super.dispose();
  }
}

class OtpArgs {
  final String phoneNumber;
  final String uid;

  OtpArgs(this.phoneNumber, this.uid);
}

class Countdown extends AnimatedWidget {
  const Countdown({Key? key, required this.animation})
      : super(key: key, listenable: animation);
  final Animation<int> animation;

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    if (clockTimer.inSeconds == 0) {
      return InkWell(
        onTap: () {
          //resend OTP
        },
        child: Text(
          'Resend OTP',
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: kPrimaryColor, fontWeight: FontWeight.w700),
        ),
      );
    }
    return Text.rich(
      TextSpan(text: "Resend OTP after: ", children: [
        TextSpan(
          text: timerText,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(context).primaryColor,
          ),
        )
      ]),
    );
  }
}
*/
