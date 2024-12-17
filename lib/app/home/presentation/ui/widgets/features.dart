import 'package:mra/app/onboarding/data/models/features.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFeatureCard extends ConsumerWidget {
  final AppFeatureModel feature;

  const AppFeatureCard({super.key, required this.feature});

  @override
  Widget build(BuildContext context, ref) {
    final theme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => feature.action(context),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: feature.bgColor,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      feature.title,
                      style: theme.labelLarge?.copyWith(color: kWhiteColor),
                    ),
                    Flexible(
                      child: Text(
                        feature.description,
                        style: theme.bodyMedium?.copyWith(
                            fontSize: 16.sp, color: kWhiteColor, height: 1.5),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
