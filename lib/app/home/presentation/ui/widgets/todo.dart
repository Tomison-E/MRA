import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ToDoCard extends StatelessWidget {
  const ToDoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SizedBox(
      height: 108.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            8.r,
          ),
          color: kWhiteColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'To do',
                    style: theme.labelLarge?.copyWith(color: kTextTitleColor),
                  ),
                  SizedBox(
                    height: 24.h,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          12.r,
                        ),
                        color: kErrorText,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.5.w,
                          ),
                          child: Text(
                            'Urgent',
                            style: theme.labelLarge
                                ?.copyWith(color: kWhiteColor, fontSize: 14.sp),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Text.rich(
                TextSpan(children: [
                  const TextSpan(
                      text:
                          'Complete your task list within 48 hours to avoid losing access to your features. '),
                  TextSpan(
                      text: 'View Checklist',
                      style: theme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500, color: kPrimaryColor))
                ]),
                style: theme.bodyMedium?.copyWith(height: 1.1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
