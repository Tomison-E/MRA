import 'package:mra/src/components/buttons/buttons.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../onboarding/presentation/ui/widgets/on_boarding_page_indicator.dart';

class ShowCaseInfoCard extends StatelessWidget {
  final int index;
  final String title;
  final String showCaseText;
  final void Function()? onCompleted;
  final void Function()? onNext;
  final void Function()? onSkip;

  final int length;

  const ShowCaseInfoCard({
    Key? key,
    required this.index,
    required this.title,
    required this.showCaseText,
    this.length = 4,
    this.onCompleted,
    this.onSkip,
    this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(top: 24.h),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: kWhiteColor,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                child: Column(
                  children: [
                    OnBoardingPageIndicator(
                      currentPage: index,
                      totalPages: length,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Text(
                        title,
                        style: theme.labelLarge,
                      ),
                    ),
                    Text(
                      showCaseText,
                      style: theme.bodyMedium,
                    ),
                    ColSpacing(
                      16.h,
                    ),
                    index == 3
                        ? CustomFilledButton(
                            width: 264.w,
                            onPressed: onCompleted,
                            buttonText: 'Complete Tutorial',
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: onSkip,
                                style: TextButton.styleFrom(
                                  foregroundColor: kGray3Color,
                                ),
                                child: const Text('Skip'),
                              ),
                              SizedBox(
                                width: 120.w,
                              ),
                              TextButton(
                                onPressed: onNext,
                                child: const Text('Next'),
                              ),
                            ],
                          )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
