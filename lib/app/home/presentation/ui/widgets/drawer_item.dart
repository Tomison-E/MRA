import 'package:mra/app/home/data/models/drawer.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerItem extends StatelessWidget {
  final DrawerItemModel item;

  const DrawerItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return SizedBox(
      height: 72.h,
      child: Row(
        children: [
          SvgPicture.asset(item.iconPath,colorFilter:
          const ColorFilter.mode(kPrimaryColor, BlendMode.srcIn),),
          RowSpacing(18.w),
          Text(
            item.title,
            style: theme.labelLarge?.copyWith(
                color: item.title == 'Log out' ? kErrorText : kTextBodyColor,),
          ),
        ],
      ),
    );
  }
}
