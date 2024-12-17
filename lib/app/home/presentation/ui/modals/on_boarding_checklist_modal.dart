import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/home/presentation/ui/widgets/on_boarding_checklist_tile.dart';
import 'package:mra/app/onboarding/data/models/on_boarding_checklist.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnBoardingChecklistBottomSheet extends ConsumerWidget {
  const OnBoardingChecklistBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).textTheme;
    final user = ref.watch(userStateProvider)!;
    final bool hasAcceptedTerms = false;
    final bool hasUploadedImg = user.profileImageUrl != null;
    final List<OnBoardingChecklistModel> checkLists = [
      const OnBoardingChecklistModel(
        task: 'Sign up to DEMS',
        isCompleted: true,
        route: 'incomplete',
      ),
      OnBoardingChecklistModel(
        task: 'Sign estate rules and regulations',
        isCompleted: hasAcceptedTerms,
        hasFocus: !hasAcceptedTerms,
        route: kRulesAndRegulationRoute,
      ),
      OnBoardingChecklistModel(
        task: 'Upload a profile picture',
        isCompleted: hasUploadedImg,
        hasFocus: !hasUploadedImg && hasAcceptedTerms,
        route: kOnBoardingProfileRoute,
      ),
    ];
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Verify your Details',
                      style: theme.labelLarge?.copyWith(color: kTextTitleColor),
                    ),
                    ColSpacing(
                      12.h,
                    ),
                    Text(
                      'You must complete all steps to fully activate your account',
                      style: theme.bodyLarge,
                    )
                  ],
                ),
              ),
            ),
            //checklist tiles
            ...checkLists
                .map(
                  (e) => OnBoardingChecklistTile(checklist: e),
                )
                .toList()
          ],
        ),
      ),
    );
  }

  static Future<void> displayModal(BuildContext context) async {
    showModalBottomSheet(
      useRootNavigator: true,
      context: context,
      isScrollControlled: true,
      backgroundColor: kWhiteColor,
      constraints: BoxConstraints.tightFor(height: 428.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) => const OnBoardingChecklistBottomSheet(),
    );
  }
}

///OnBoarding checklists
