import 'package:mra/app/services/data/models/service_staff.dart';
import 'package:mra/app/services/presentation/ui/widgets/staff_tile.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/state_views/empty_state.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ServiceBottomSheet extends StatelessWidget {
  final List<ServiceStaff> artisans;

  const ServiceBottomSheet({super.key, required this.artisans});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    if (artisans.isEmpty) {
      return const EmptyState(kEmptyServicesSvg,
          info:
              "When your estate admin adds artisans, they will be listed here");
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          ColSpacing(40.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                artisans.first.type.name.toUpperCase(),
                style: theme.labelLarge,
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: SvgPicture.asset(kCancelSvg),
                padding: EdgeInsets.zero,
              )
            ],
          ),
          ColSpacing(48.h),
          Expanded(
            child: ListView(
              children:
                  artisans.map((e) => ServiceStaffTile(staff: e)).toList(),
            ),
          )
        ],
      ),
    );
  }

  static void displayModal(BuildContext context,
      {required List<ServiceStaff> artisans}) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: kWhiteColor,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) => ServiceBottomSheet(
        artisans: artisans,
      ),
    );
  }
}
