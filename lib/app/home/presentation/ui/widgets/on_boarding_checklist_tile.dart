import 'package:mra/app/onboarding/data/models/on_boarding_checklist.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class OnBoardingChecklistTile extends StatelessWidget {
  final OnBoardingChecklistModel checklist;

  const OnBoardingChecklistTile({Key? key, required this.checklist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: InkWell(
        onTap: () {
          if (!checklist.isCompleted) {
            context.pushNamed(checklist.route);
          }
        },
        child: SizedBox(
          height: 64.h,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: checklist.hasFocus ? kEBF1FD : kF6F6FA,
              borderRadius: BorderRadius.circular(
                12.r,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    checklist.task,
                    style: theme.labelLarge?.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  Text(
                    checklist.isCompleted ? 'Done' : 'Start',
                    style: theme.labelLarge?.copyWith(
                        color: checklist.isCompleted
                            ? kSuccessColor
                            : kPrimaryColor,),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
