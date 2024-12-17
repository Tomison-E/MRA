import 'package:mra/app/payments/data/models/invoice.dart';
import 'package:mra/app/payments/domain/use_cases/use_cases.dart';
import 'package:mra/app/payments/presentation/ui/screens/payment_view.dart';
import 'package:mra/src/components/currency_view/currency_view.dart';
import 'package:mra/src/components/loader/loader.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:mra/src/res/assets/svgs/svgs.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class InvoiceView extends ConsumerWidget {
  final Invoice invoice;
  const InvoiceView({super.key, required this.invoice});

  @override
  Widget build(BuildContext context, ref) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return PopScope(
      canPop: !Loader.isLoading,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(invoice.title, style: textTheme.headlineSmall),
            ColSpacing(40.h),
            SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colorScheme.primary,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(25.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Amount",
                        style:
                            textTheme.labelMedium?.copyWith(color: kWhiteColor),
                      ),
                      CurrencyView(
                        invoice.amount,
                        amountStyle:
                            textTheme.titleMedium?.copyWith(color: kWhiteColor),
                      )
                    ],
                  ),
                ),
              ),
            ),
            ColSpacing(40.h),
            DecoratedBox(
              decoration: BoxDecoration(
                color: kFormFilledColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sub total",
                          style: textTheme.bodyMedium
                              ?.copyWith(color: kTextBodyColor),
                        ),
                        CurrencyView(
                          invoice.amount,
                          amountStyle: textTheme.titleMedium
                              ?.copyWith(color: kHelperTextColor),
                        )
                      ],
                    ),
                    ColSpacing(20.h),
                    const Divider(),
                    ColSpacing(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Service fee",
                          style: textTheme.bodyMedium
                              ?.copyWith(color: kTextBodyColor),
                        ),
                        RowSpacing(5.w),
                        SvgPicture.asset(kInfoSvg),
                        const Spacer(),
                        CurrencyView(
                          invoice.amount,
                          amountStyle: textTheme.titleMedium
                              ?.copyWith(color: kHelperTextColor),
                        )
                      ],
                    ),
                    ColSpacing(20.h),
                    const Divider(),
                    ColSpacing(20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total",
                          style: textTheme.bodyMedium
                              ?.copyWith(color: kTextBodyColor),
                        ),
                        CurrencyView(invoice.amount,
                            amountStyle: textTheme.titleMedium)
                      ],
                    )
                  ],
                ),
              ),
            ),
            ColSpacing(100.h),
            FilledButton(
              onPressed: () => initPayment(context, ref),
              child: const Text("Pay Now"),
            ),
          ],
        ),
      ),
    );
  }

  void initPayment(BuildContext context, WidgetRef ref) async {
    Loader.show(context);
    final response = await ref
        .read(initPaymentUseCaseProvider(List.unmodifiable([invoice])));
    Loader.hide();
    response.when(success: (success) {
      Navigator.pop(context);
      context.pushNamed(kPaymentViewRoute,
          extra: PaymentViewInfo(success, invoice));
    }, apiFailure: (error, _) {
      return Toast.apiError(error, context);
    });
  }

  static void displayModal(BuildContext context, Invoice invoice) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: BoxConstraints.tightForFinite(height: 750.h),
      backgroundColor: kWhiteColor,
      showDragHandle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) => InvoiceView(
        invoice: invoice,
      ),
    );
  }
}
