import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:mra/app/notice_board/data/models/announcement.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/extensions/dates.dart';
import 'package:mra/src/extensions/strings.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../src/res/assets/svgs/svgs.dart';

class NoticeBoardCard extends StatelessWidget {
  final Announcement announcement;
  const NoticeBoardCard({Key? key, required this.announcement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: kWhiteColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              announcement.description.capitalize,
              style: theme.bodyLarge,
            ),
            ColSpacing(
              24.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  announcement.createdAt.toGroupName(),
                  style: theme.bodyMedium
                      ?.copyWith(color: kHelperTextColor, fontSize: 12.sp),
                ),
                if (announcement.startDate != null &&
                    announcement.endDate != null)
                  InkWell(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: kE9F5FF,
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Add to Calendar',
                              style: theme.bodyMedium?.copyWith(
                                color: kPrimaryColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            RowSpacing(
                              6.w,
                            ),
                            SvgPicture.asset(
                              kAddSvg,
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      Add2Calendar.addEvent2Cal(
                        Event(
                          title: announcement.title,
                          description: announcement.description,
                          startDate: announcement.startDate!,
                          endDate: announcement.endDate!,
                          allDay: false,
                        ),
                      );
                    },
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}
