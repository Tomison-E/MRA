import 'package:mra/app/services/data/models/estate_service.dart';
import 'package:mra/app/services/data/models/service_staff.dart';
import 'package:mra/app/services/presentation/ui/modals/service_bottom_sheet.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/assets/svgs/svgs.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceTile extends StatelessWidget {
  final EstateService service;
  final List<ServiceStaff> artisans;
  const ServiceTile({super.key, required this.service, required this.artisans});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: () {
          ServiceBottomSheet.displayModal(context, artisans: artisans);
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: kWhiteColor,
              border: Border.all(width: 0.5, color: kGray5Color),
              borderRadius: BorderRadius.circular(8.r)),
          child: SizedBox(
            height: 64,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    service.iconPath,
                    height: 24,
                  ),
                  RowSpacing(8.w),
                  Text(
                    service.name,
                    style: theme.labelLarge
                        ?.copyWith(color: kTextTitleColor, height: 1.5.h),
                  ),
                  const Spacer(),
                  SvgPicture.asset(kRightArrowSvg)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
