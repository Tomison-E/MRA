import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MainHostCard extends ConsumerWidget {
  const MainHostCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).textTheme;
    final user = ref.watch(userStateProvider)!;
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12.r,
          ),
          color: kWhiteColor),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w, top: 10.h),
              child: Text(
                'Main host',
                style: theme.labelLarge,
              ),
            ),
            ColSpacing(16.h),
            const Divider(
              thickness: 0.5,
              color: kGray5Color,
            ),
            ColSpacing(16.h),
            Row(
              children: [
                SvgPicture.asset(
                  kProfileIconSvg,
                  width: 56.w,
                ),
                RowSpacing(16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${user.firstName} ${user.lastName}'),
                    ColSpacing(16.h),
                    Text(user.houseHold.houseNumber)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
