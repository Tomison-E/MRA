import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/payments/domain/params/invoice_params.dart';
import 'package:mra/app/payments/presentation/logic/invoice_state.dart';
import 'package:mra/app/payments/presentation/ui/widgets/upcoming_payment_tile.dart';
import 'package:mra/src/components/margin.dart';
import 'package:mra/src/components/state_views/empty_state.dart';
import 'package:mra/src/components/state_views/error_state.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//GRIDVIEW NOT STRETCHING TO SIDE OF THE SCREEN

class InvoicesView extends ConsumerStatefulWidget {
  const InvoicesView({Key? key}) : super(key: key);

  @override
  ConsumerState<InvoicesView> createState() => _InvoicesViewState();
}

class _InvoicesViewState extends ConsumerState<InvoicesView> {
  late var userId = ref.read(userStateProvider)!.id;
  late var params = InvoiceParams.upcoming(userId);

  final ScrollController _scrollController = ScrollController();
  late final nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels > nextPageTrigger) {
        if ((ref.read(invoiceStateProvider(params)).value?.length ?? 0) %
                params.limit ==
            0) {
          ref.read(invoiceStateProvider(params).notifier).fetchMoreInvoices();
        }
      }
    });
  }

  @override
  void initState() {
    scrollListener();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final invoiceState = ref.watch(invoiceStateProvider(params));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming'),
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
              if (invoiceState.isRefreshing) ...[loading(), ColSpacing(24.h)],
              invoiceState.when(
                data: (invoices) {
                  if (invoices.isEmpty) {
                    return const EmptyState(
                      kEmptyHistorySvg,
                      info:
                          'You currently have no upcoming payments but when you do, it’ll be here',
                    );
                  }
                  return Column(
                      children: invoices
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
                    retryAction: refreshInvoices,
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

  void refreshInvoices() => ref.invalidate(invoiceStateProvider);
  Future<void> refresh() async {
    refreshInvoices();
  }
}
