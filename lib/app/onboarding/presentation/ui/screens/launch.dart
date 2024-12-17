// todo screen where we have the continue as resident or agent : Column(Expanded(),Contents())
//todo make use of FilledButton Widget for both buttons define the themedata on the theme file
//todo use theme for textstyles

import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LaunchScreen extends ConsumerStatefulWidget {
  const LaunchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _LaunchScreen();
  }
}

class _LaunchScreen extends ConsumerState<LaunchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SvgPicture.asset(kLogoSvg,theme: const SvgTheme(currentColor: kPrimaryColor),),
              ),
            ),
            FilledButton(
              onPressed: () => context.pushNamed(kVerifyDetailsRoute),
              child: const Text(
                'Continue',
              ),
            ),
   /*         ColSpacing(16.h),
            FilledButton(
              onPressed: () => context.pushNamed(kLoginRoute),
              style: FilledButton.styleFrom(
                backgroundColor: kWhiteColor,
                foregroundColor: kPrimaryBlackColor,
                side: const BorderSide(color: kPrimaryBlackColor, width: 1),
              ),
              child: const Text(
                'Continue as Security agent',
              ),
            ),*/
            ColSpacing(124.h)
          ],
        ),
      ),
    );
  }
}
