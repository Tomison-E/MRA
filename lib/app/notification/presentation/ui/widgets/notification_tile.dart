import 'package:mra/src/components/margin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../src/res/assets/svgs/svgs.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          SvgPicture.asset(kSecurityAlertSvg),
          RowSpacing(16.w),
          const Text('You have one pending security alert')
        ],
      ),
    );
  }
}
