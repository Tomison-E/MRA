import 'package:mra/app/payments/data/models/payment_category.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PaymentCategoryCard extends StatelessWidget {
  final PaymentCategoryModel category;

  const PaymentCategoryCard({Key? key, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Column(
      children: [
        SvgPicture.asset(
          category.iconPath,
          width: 48,
        ),
        ColSpacing(
          8.h,
        ),
        Text(
          category.label,
          style: theme.bodyMedium?.copyWith(
            color: kTextTitleColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
