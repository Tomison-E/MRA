import 'package:mra/app/access_control/presentation/ui/modals/invite_guest.dart';
import 'package:mra/src/components/buttons/buttons.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/assets/svgs/svgs.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyGuestWidget extends StatelessWidget {
  const EmptyGuestWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        ColSpacing(
          72.h,
        ),
        SvgPicture.asset(
          kAccessKeyCardSvg,
        ),
        Text(
          'Invite a Guest',
          style: theme.titleLarge?.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            color: kPrimaryBlackColor,
          ),
        ),
        ColSpacing(
          16.h,
        ),
        const Text('Give your guest access into the estate'),
        ColSpacing(40.h),
        CustomFilledButton(
          onPressed: () {
            InviteGuestBottomSheet.displayModal(context);
          },
          buttonText: 'Invite Guest',
        )
      ],
    );
  }
}
