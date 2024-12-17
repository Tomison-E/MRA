import 'package:mra/app/payments/data/models/invoice.dart';
import 'package:mra/src/components/currency_view/currency_view.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TransactionTile extends StatelessWidget {
  final Invoice transaction;

  const TransactionTile({Key? key, required this.transaction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12.r,
        ),
      ),
      tileColor: kWhiteColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
      leading: SvgPicture.asset(
        transaction.type.icon,
        width: 48.w,
      ),
      title: Text(transaction.title),
      subtitle: Text(
        transaction.title,
        style: theme.bodyLarge?.copyWith(
          fontSize: 12.sp,
          color: kHelperTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: CurrencyView(transaction.amount),
    );
  }
}
