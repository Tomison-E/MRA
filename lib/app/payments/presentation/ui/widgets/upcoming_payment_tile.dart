import 'package:mra/app/payments/data/models/invoice.dart';
import 'package:mra/app/payments/presentation/ui/modals/invoice_view.dart';
import 'package:mra/src/components/buttons/buttons.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpcomingPaymentTile extends StatelessWidget {
  final Invoice item;

  const UpcomingPaymentTile({Key? key, required this.item}) : super(key: key);

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
      contentPadding: EdgeInsets.only(left: 8.w),
      leading: SvgPicture.asset(
        item.type.icon,
        width: 48.w,
      ),
      title: Text(item.title),
      subtitle: Text(
        item.title,
        style: theme.bodyLarge?.copyWith(
          fontSize: 12.sp,
          color: kHelperTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: CustomTextButton(
        onPressed: ()=> InvoiceView.displayModal(context, item),
        buttonText: 'Pay Now',
      ),
    );
  }
}
