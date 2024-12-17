import 'package:mra/app/access_control/data/models/guest.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/extensions/dates.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GuestHistoryCard extends StatelessWidget {
  final Guest guest;

  const GuestHistoryCard({Key? key, required this.guest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r), color: kWhiteColor),
        child: Padding(
          padding: EdgeInsets.all(
            16.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                guest.name,
                style: theme.titleMedium,
              ),
              ColSpacing(
                24.h,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(kGuestInSvg),
                      RowSpacing(
                        8.w,
                      ),
                      Text(
                        guest.checkInTime!.toTime,
                        style: theme.titleMedium
                            ?.copyWith(color: kSemanticSuccessColor),
                      )
                    ],
                  ),
                  RowSpacing(
                    80.w,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        guest.yetToCheckout ? kGuestOutSvg : kGuestOutRedSvg,
                      ),
                      RowSpacing(
                        8.w,
                      ),
                      Text(
                        guest.yetToCheckout
                            ? 'Yet to checkout'
                            : guest.checkOutTime!.toTime,
                        style: theme.titleMedium?.copyWith(
                            color: guest.yetToCheckout
                                ? kHelperTextColor
                                : kErrorText),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
