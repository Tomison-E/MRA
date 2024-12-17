import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

///iconPath must be in SVG format
class SocialLoginButton extends StatelessWidget {
  final String iconPath;
  final String actionText;
  final void Function()? onTap;
  final MainAxisAlignment? textAlignment;

  const SocialLoginButton(
      {Key? key,
      required this.iconPath,
      required this.actionText,
      required this.onTap,this.textAlignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SizedBox(
      height: 56.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r), color: kWhiteColor,),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(mainAxisAlignment: textAlignment??MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(iconPath),
              RowSpacing(4.w),
              Text(
                actionText,
                style: theme.labelLarge?.copyWith(height: 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}
