import 'package:mra/app/onboarding/data/models/onboarding.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingCard extends StatelessWidget {
  const OnBoardingCard(
      {Key? key,
      required this.currentPage,
      required this.animation,
      required this.index,
      required this.onBoardingModel,})
      : super(key: key);
  final int currentPage;
  final Animation<Offset> animation;
  final int index;
  final OnBoardingModel onBoardingModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        index == currentPage
            ? SlideTransition(
                position: animation,
                child: Padding(
                  padding: EdgeInsets.only(left: 40.w),
                  child: Image.asset(
                    onBoardingModel.imagePath,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              )
            : const SizedBox.shrink(),
        SizedBox(
          width: double.infinity,
          height: 132.h,
          child: DecoratedBox(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: kFEFEFE,
                boxShadow: [
                  BoxShadow(
                      color: kWhiteColor.withOpacity(.08),
                      offset: const Offset(0, -4),
                      blurRadius: 32,)
                ],),
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Column(
                children: [
                  Text(onBoardingModel.title, style: theme.titleLarge),
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      onBoardingModel.details,
                      textAlign: TextAlign.center,
                      style:
                          theme.titleMedium?.copyWith(color: kHelperTextColor),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
