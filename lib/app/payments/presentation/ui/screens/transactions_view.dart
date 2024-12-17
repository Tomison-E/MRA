import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/payments/domain/params/invoice_params.dart';
import 'package:mra/app/payments/presentation/logic/transactions_state.dart';
import 'package:mra/app/payments/presentation/ui/widgets/upcoming_payment_tile.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/state_views/empty_state.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionsView extends ConsumerStatefulWidget {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  ConsumerState<TransactionsView> createState() => _TransactionsViewState();
}

class _TransactionsViewState extends ConsumerState<TransactionsView> {
  late var userId = ref.read(userStateProvider)!.id;
  late var params = InvoiceParams.transactions(userId);

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final ScrollController _scrollController = ScrollController();
  late final nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > nextPageTrigger) {
        if ((ref.read(transactionStateProvider(params)).value?.length ?? 0) %
                params.limit ==
            0) {
          ref
              .read(transactionStateProvider(params).notifier)
              .fetchMoreTransactions();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final transactionState = ref.watch(transactionStateProvider(params));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: refresh,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ColSpacing(
                24.h,
              ),
              if (transactionState.isRefreshing) ...[
                loading(),
                ColSpacing(24.h)
              ],
              transactionState.when(
                data: (transactions) {
                  if (transactions.isEmpty) {
                    return const EmptyState(
                      kEmptyHistorySvg,
                      info:
                          'You currently have no transactions, but when you do, it’ll be here',
                    );
                  }
                  return Column(
                      children: transactions
                          .map(
                            (e) => Padding(
                              padding: EdgeInsets.only(bottom: 8.h),
                              child: UpcomingPaymentTile(
                                item: e,
                              ),
                            ),
                          )
                          .toList());
                },
                error: (error, _) => Center(
                  child: ErrorState(
                    error: error,
                    retryAction: refreshTransactions,
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

  void refreshTransactions() => ref.invalidate(transactionStateProvider);
  Future<void> refresh() async {
    refreshTransactions();
  }
}
