import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/text_fields/form_field.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../src/res/assets/svgs/svgs.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Feedback',
        ),
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: SvgPicture.asset(kBackIconSvg),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Help us improve DEMS',
                  style: theme.bodyLarge?.copyWith(color: kTextTitleColor),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                  color: kCDCCD1, borderRadius: BorderRadius.circular(8.r)),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  'We highly appreciate your '
                  'feedback. If you require assistance or have any'
                  ' concerns regarding our services, please don\'t '
                  'hesitate to feel the form below.',
                  style: theme.bodyLarge,
                ),
              ),
            ),
            ColSpacing(40.h),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: CustomFormField(
                label: 'Please select the feature you want to give feedback on',
                textField: DropdownButtonFormField(
                  items: const [],
                  hint: const Text('Select feature'),
                  onChanged: (value) {},
                ),
              ),
            ),
            CustomFormField(
              label: 'How can we make your experience better',
              textField: TextFormField(
                minLines: 8,
                maxLines: 10,
              ),
            ),
            ColSpacing(40.h),
            FilledButton(onPressed: () {}, child: const Text('Submit Feedback'))
          ],
        ),
      ),
    );
  }
}
