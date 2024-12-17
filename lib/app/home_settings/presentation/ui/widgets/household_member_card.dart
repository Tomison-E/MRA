import 'package:mra/app/home_settings/data/models/personnel.dart';
import 'package:mra/app/home_settings/presentation/ui/modals/add_household_bottom_sheet.dart';
import 'package:mra/app/home_settings/presentation/ui/widgets/household_member_details.dart';
import 'package:mra/src/components/buttons/filled_button.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HouseHoldCard extends StatelessWidget {
  final String title;
  final List<Personnel> personnel;
  final PersonnelType type;

  const HouseHoldCard(
      {Key? key,
      required this.title,
      required this.personnel,
      required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            12.r,
          ),
          color: kWhiteColor),
      child: Padding(
        padding: EdgeInsets.all(16.h),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 10.w, top: 10.h),
                child: Text(
                  title,
                  style: theme.labelLarge,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: const Divider(
                thickness: 0.5,
                color: kGray5Color,
              ),
            ),
            ...personnel
                .where((element) => element.type == type)
                .map(
                  (e) => HouseHoldMembersDetails(
                    personnel: e,
                  ),
                )
                .toList(),
            CustomFilledButton(
              onPressed: () {
                AddHouseholdBottomSheet.displayModal(context, type: type);
              },
              style: FilledButton.styleFrom(
                  backgroundColor: kE9F5FF,
                  foregroundColor: kPrimaryColor,
                  textStyle:
                      theme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
              customChild: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Add new ${type.name}'),
                  RowSpacing(10.w),
                  const Icon(Icons.add_circle)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
