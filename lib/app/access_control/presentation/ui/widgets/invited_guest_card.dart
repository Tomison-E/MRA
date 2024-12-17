import 'package:mra/app/access_control/data/models/guest.dart';
import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:share_plus/share_plus.dart';

class InvitedGuestCard extends ConsumerWidget {
  final Guest guest;
  const InvitedGuestCard({Key? key, required this.guest}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: kWhiteColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Invited Guest', style: theme.labelLarge),
            ),
            const Divider(
              thickness: 0.5,
              color: kGray4Color,
            ),
            Row(
              children: [
                SvgPicture.asset(kProfileIconSvg),
                RowSpacing(16.w),
                Column(
                  children: [
                    const Text(
                      'Name',
                    ),
                    ColSpacing(
                      16.h,
                    ),
                    const Text('Code')
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        guest.name,
                        style: theme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ColSpacing(16.h),
                      Text(
                        guest.accessCode,
                        style: theme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        kShareSvg,
                      ),
                      ColSpacing(
                        8.h,
                      ),
                      Text(
                        'Share',
                        style: theme.bodyMedium?.copyWith(
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    final RenderBox box =
                        context.findRenderObject() as RenderBox;
                    Share.share(
                        '${ref.read(userStateProvider)!.firstName} has invited you to ${ref.read(userStateProvider)!.estate.name} with code : ${guest.accessCode}',
                        subject:
                            '${ref.read(userStateProvider)!.firstName} has invited you to ${ref.read(userStateProvider)!.estate.name}',
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
