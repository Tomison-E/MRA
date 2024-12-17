import 'package:mra/app/payments/data/models/payment_category.dart';
import 'package:mra/app/payments/presentation/logic/payments_state.dart';
import 'package:mra/app/payments/presentation/ui/widgets/payment_category_card.dart';
import 'package:mra/app/payments/presentation/ui/widgets/transaction_tile.dart';
import 'package:mra/app/payments/presentation/ui/widgets/upcoming_payment_tile.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/state_views/empty_state.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/res/assets/svgs/svgs.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

//GRIDVIEW NOT STRETCHING TO SIDE OF THE SCREEN

class Payments extends ConsumerStatefulWidget {
  const Payments({Key? key}) : super(key: key);

  @override
  ConsumerState<Payments> createState() => _PaymentsState();
}

class _PaymentsState extends ConsumerState<Payments> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final paymentState = ref.watch(paymentStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments'),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refreshPaymentData,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColSpacing(
                24.h,
              ),
              Wrap(
                spacing: 40.w,
                runSpacing: 30.h,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                children: List.generate(
                  _paymentCategories.length,
                  (index) =>
                      PaymentCategoryCard(category: _paymentCategories[index]),
                ),
              ),
              paymentState.when(
                data: (state) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ColSpacing(
                          70.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Upcoming',
                              style: theme.labelLarge?.copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                            TextButton(
                                onPressed: () =>
                                    context.pushNamed(kInvoicesViewRoute),
                                child: const Text('See More'),)
                          ],
                        ),
                        ColSpacing(
                          24.h,
                        ),
                        if (paymentState.isRefreshing) ...[
                          loading(),
                          ColSpacing(24.h)
                        ],
                        if (state.invoices.isEmpty)
                          const EmptyState(
                            kEmptyHistorySvg,
                            isComponentWidget: true,
                            info:
                                'You currently have no upcoming payments but when you do, it’ll be here',
                          )
                        else
                          ...state.invoices
                              .map(
                                (e) => Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: UpcomingPaymentTile(
                                    item: e,
                                  ),
                                ),
                              )
                              .toList(),
                        ColSpacing(
                          70.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Transactions',
                              style: theme.labelLarge?.copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  context.pushNamed(kTransactionsViewRoute),
                              child: const Text('See More'),
                            )
                          ],
                        ),
                        ColSpacing(
                          24.h,
                        ),
                        if (state.transactions.isEmpty)
                          const EmptyState(
                            kEmptyHistorySvg,
                            isComponentWidget: true,
                            info:
                                'You currently have no transactions but when you do, it’ll be here',
                          )
                        else
                          ...state.transactions
                              .map(
                                (e) => Padding(
                                  padding: EdgeInsets.only(bottom: 8.h),
                                  child: TransactionTile(
                                    transaction: e,
                                  ),
                                ),
                              )
                              .toList(),
                      ]);
                },
                error: (error, _) => Center(
                  child: ErrorState(
                    error: error,
                    retryAction: refreshPaymentData,
                  ),
                ),
                loading: () => loading(),
              ),
              ColSpacing(
                24.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget loading() => const Center(child: CircularProgressIndicator());

  Future<void> refreshPaymentData() async =>
      ref.invalidate(paymentStateProvider);
}

//payment categories
List<PaymentCategoryModel> _paymentCategories = [
  PaymentCategoryModel(iconPath: kElectricitySvg, label: 'Electricity'),
  PaymentCategoryModel(iconPath: kWaterSvg, label: 'Water'),
  PaymentCategoryModel(iconPath: kEstateDuesSvg, label: 'Estate Dues'),
  PaymentCategoryModel(iconPath: kInternetSvg, label: 'Internet'),
  PaymentCategoryModel(iconPath: kTaxLevySvg, label: 'Tax Levy'),
];
