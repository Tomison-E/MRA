import 'package:mra/app/services/data/models/service_staff.dart';
import 'package:mra/app/services/presentation/ui/widgets/star_rating.dart';
import 'package:mra/src/components/buttons/buttons.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/res/assets/images/images.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:textstyle_extensions/textstyle_extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class ServiceStaffTile extends StatelessWidget {
  final ServiceStaff staff;

  const ServiceStaffTile({super.key, required this.staff});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 56,
              child: Image.asset(
                staff.profileImg ?? kEstateLogoImg,
                fit: BoxFit.fitWidth,
              ),
            ),
            RowSpacing(16.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(staff.name),
                ColSpacing(16.h),
                Row(
                  children: [
                    StarRating(rating: staff.rating),
                    const RowSpacing(10),
                    Text(
                      "(${staff.totalRating})",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.textColor(kHelperTextColor),
                    )
                  ],
                )
              ],
            ),
            const Spacer(),
            CustomTextButton(
                onPressed: () async {
                  final link = 'tel:${Uri.encodeComponent(staff.phoneNumber)}';

                  if (await canLaunchUrl(Uri.parse(link))) {
                    launchUrl(Uri.parse(link));
                  } else if (context.mounted) {
                    Toast.error("Failed to launch contact", context);
                  }
                },
                buttonText: 'Book')
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
}
