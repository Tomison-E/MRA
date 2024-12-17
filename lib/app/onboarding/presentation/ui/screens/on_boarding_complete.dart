import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/assets/gifs/gifs.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

///TODO: MAKE SCREEN DISAPPEAR AFTER 4 SECONDS

class OnBoardingCompleteScreen extends StatefulWidget {
  const OnBoardingCompleteScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingCompleteScreen> createState() => _OnBoardingCompleteScreenState();
}

class _OnBoardingCompleteScreenState extends State<OnBoardingCompleteScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 4000), () async {
      context.goNamed(kHomeRoute);
    });

  }
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context).textTheme;

    return Scaffold(backgroundColor: kF5F2FF,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            ColSpacing(
              108.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Onboarding Completed',
                style: theme.headlineSmall?.copyWith(
                  color: kTextTitleColor,
                ),
              ),
            ),
            ColSpacing(
              24.h,
            ),
            Text(
              'Congratulations you’ve successfully completed your onboarding',
              style: theme.bodyLarge,
            ),
            ColSpacing(
              64.h,
            ),
            Image.asset(kSuccessGif,width: 400.w,fit: BoxFit.fitWidth,),
          ],
        ),
      ),
    );
  }
}
