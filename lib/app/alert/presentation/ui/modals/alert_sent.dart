import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../../src/res/assets/svgs/svgs.dart';

class AlertSentModal extends StatelessWidget {
  const AlertSentModal({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return PopScope(
        canPop: false,
        onPopInvoked: (_){
          context.goNamed(kHomeRoute);
        },
        child: Dialog(
          child: Padding(
            padding: EdgeInsets.all(35.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(kAlertSentSvg),
                ColSpacing(24.h),
                Text(
                  'Alert Sent',
                  style: theme.labelLarge?.copyWith(color: kTextTitleColor),
                ),
                ColSpacing(8.h),
                Text(
                  'The estate security has successfully been alerted',
                  style: theme.bodySmall?.copyWith(height: 1.6.h),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
       );
  }

  static void showSentDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const AlertSentModal());
  }
}
