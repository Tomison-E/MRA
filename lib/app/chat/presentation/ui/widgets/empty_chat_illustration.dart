import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyChatIllustration extends StatelessWidget {
  const EmptyChatIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ColSpacing(48),
          SvgPicture.asset(
            kEmptyChatSvg,
            width: 248.w,
          ),
          const ColSpacing(8),
          Text(
            'You currently have not conversation\nwith your estate admin',
            textAlign: TextAlign.center,
            style: theme.bodyLarge,
          )
        ],
      ),
    );
  }
}
