import 'dart:async';
import 'package:mra/app/payments/data/models/invoice.dart';
import 'package:mra/app/payments/domain/params/invoice_params.dart';
import 'package:mra/app/payments/domain/use_cases/use_cases.dart';
import 'package:mra/app/payments/presentation/logic/payments_state.dart';
import 'package:mra/core/service_result/src/api_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionState extends FamilyAsyncNotifier<List<Invoice>, InvoiceParams> {
  @override
  FutureOr<List<Invoice>> build(arg) async {
    return fetchTransactions();
  }

  FutureOr<List<Invoice>> fetchTransactions() async {
    return ref.read(paymentStateProvider).unwrapPrevious().valueOrNull?.transactions ?? (await ref.read(fetchInvoicesUseCaseProvider(arg))).extract();
  }

  Future<ApiResult<List<Invoice>>> fetchMoreTransactions() async {
    final members = state.value;
    final value =
    await ref.read(fetchInvoicesUseCaseProvider(arg.incrementPage()));
    value.when(
      success: (value) async {
        state = const AsyncLoading();
        members?.addAll(value);
        state = AsyncData(members!);
      },
      apiFailure: (_, __) => state = AsyncData(members ?? []),
    );
    return value;
  }
}

final transactionStateProvider =
AsyncNotifierProviderFamily<TransactionState, List<Invoice>, InvoiceParams>(
        () => TransactionState());
