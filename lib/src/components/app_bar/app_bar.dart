import 'package:mra/src/res/assets/svgs/svgs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLeadingIcon;
  final String? title;

  const CustomAppBar({Key? key, this.showLeadingIcon = true, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return AppBar(
      leading: showLeadingIcon
          ? InkWell(
              onTap: () => context.pop(), child: SvgPicture.asset(kBackIconSvg),)
          : null,
      title: title != null
          ? Text(
              title!,
              style: theme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size(428.w, 40);
}
