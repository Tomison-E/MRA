import 'package:mra/app/home_settings/data/models/personnel.dart';
import 'package:mra/app/home_settings/home_settings_providers.dart';
import 'package:mra/src/components/loader/loader.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../src/res/assets/assets.dart';

class HouseHoldMembersDetails extends ConsumerWidget {
  final Personnel personnel;

  const HouseHoldMembersDetails({Key? key, required this.personnel})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
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
                Text(
                  "${personnel.firstName} " "${personnel.lastName}",
                ),
                ColSpacing(16.h),
                Text(personnel.type == PersonnelType.staff
                    ? personnel.type.name
                    : personnel.phoneNumber),
              ],
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                removeMembers(context, ref, personnel);
              },
              icon: const Icon(
                Icons.remove_circle,
              ),
              color: kErrorText,
            )
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: const Divider(
            thickness: 0.5,
            color: kGray5Color,
          ),
        ),
      ],
    );
  }

  void removeMembers(
      BuildContext context, WidgetRef ref, Personnel person) async {
    Loader.show(context);
    final response = await ref
        .read(houseHoldStateProvider.notifier)
        .deletePersonnel(person.id);
    Loader.hide();
    response.when(
        success: (_) {
          Toast.success("${person.firstName} removed successfully", context);
        },
        apiFailure: (err, _) => Toast.apiError(err, context));
  }
}
