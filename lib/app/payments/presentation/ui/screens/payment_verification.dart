import 'package:mra/app/payments/data/models/transaction.dart';
import 'package:mra/app/payments/domain/use_cases/use_cases.dart';
import 'package:mra/app/payments/presentation/logic/invoice_state.dart';
import 'package:mra/app/payments/presentation/logic/transactions_state.dart';
import 'package:mra/app/payments/presentation/providers/providers.dart';
import 'package:mra/app/payments/presentation/ui/screens/payment_view.dart';
import 'package:mra/src/components/currency_view/currency_view.dart';
import 'package:mra/src/components/loader/loader.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/components/toast/toast.dart';
import 'package:intl/intl.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/res/assets/gifs/gifs.dart';
import 'package:mra/src/res/styles/colors/colors.dart';
import 'package:mra/src/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class PaymentVerification extends ConsumerStatefulWidget {
  final PaymentViewInfo info;
  const PaymentVerification(this.info, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _PaymentVerification();
  }
}

class _PaymentVerification extends ConsumerState<PaymentVerification> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final state =
        ref.watch(verifyPaymentProvider(widget.info.intent.reference));
    ref.listen(verifyPaymentProvider(widget.info.intent.reference),
        (previous, next) {
      next.whenData((value) {
        if (value.status == TransactionStatus.pending ||
            value.status == TransactionStatus.paid) {
          refreshTransactions();
        }
      });
    });
    return PopScope(
      canPop: !(state.isLoading || state.isRefreshing || state.isReloading),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: state.when(
              skipLoadingOnRefresh: false,
              data: (success) {
                switch (success.status) {
                  case TransactionStatus.failed:
                    return ErrorState(
                        message: "Payment Failed", retryAction: retryPayment);
                  case TransactionStatus.paid || TransactionStatus.pending:
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () => context.goNamed(kPaymentsRoute),
                            child: const Text('Done'),
                          ),
                        ),
                        ColSpacing(50.h),
                        Image.asset(
                          kCompletedGif,
                          height: 150,
                        ),
                        ColSpacing(50.h),
                        Text("Payment ${success.status.name}",
                            style: textTheme.titleLarge),
                        ColSpacing(50.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child:
                              Text("Details", style: textTheme.headlineSmall),
                        ),
                        ColSpacing(50.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Amount Paid",
                              style: textTheme.bodyLarge
                                  ?.copyWith(color: kTextBodyColor),
                            ),
                            CurrencyView(
                              widget.info.invoice.amount,
                              amountStyle: textTheme.bodyLarge
                                  ?.copyWith(color: colorScheme.primary),
                            )
                          ],
                        ),
                        const ColSpacing(30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Status",
                              style: textTheme.bodyLarge
                                  ?.copyWith(color: kTextBodyColor),
                            ),
                            Text(
                              success.status.name,
                              style: textTheme.bodyLarge
                                  ?.copyWith(color: colorScheme.primary),
                            )
                          ],
                        ),
                        const ColSpacing(30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Date",
                              style: textTheme.bodyLarge
                                  ?.copyWith(color: kTextBodyColor),
                            ),
                            Text(
                              DateFormat.yMd().add_jm().format(DateTime.now()),
                              style: textTheme.bodyLarge
                                  ?.copyWith(color: colorScheme.primary),
                            )
                          ],
                        ),
                      ],
                    );
                }
              },
              error: (error, __) =>
                  ErrorState(error: error, retryAction: retryVerification),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshTransactions() async {
    ref.invalidate(invoiceStateProvider);
    ref.invalidate(transactionStateProvider);
  }

  void retryPayment() async {
    Loader.show(context);
    final res = await ref.read(
      initPaymentUseCaseProvider(
        List.unmodifiable([widget.info.invoice]),
      ),
    );
    Loader.hide();
    res.when(
      success: (paymentRef) =>
          context.goNamed(kPaymentViewRoute, extra: widget.info),
      apiFailure: (error, _) => Toast.apiError(error, context, duration: 5),
    );
  }

  void retryVerification() => ref.invalidate(verifyPaymentProvider);
}
