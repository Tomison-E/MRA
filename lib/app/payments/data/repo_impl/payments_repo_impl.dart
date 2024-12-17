import 'package:mra/app/payments/data/data_source/payments_source.dart';
import 'package:mra/app/payments/data/data_source/payments_source_impl.dart';
import 'package:mra/app/payments/data/models/invoice.dart';
import 'package:mra/app/payments/data/models/payment.dart';
import 'package:mra/app/payments/data/models/payment_intent.dart';
import 'package:mra/app/payments/data/models/transaction.dart';
import 'package:mra/app/payments/domain/params/invoice_params.dart';
import 'package:mra/app/payments/domain/repo/payments_repo.dart';
import 'package:mra/core/helpers/dio_interceptor.dart';
import 'package:mra/core/service_result/src/api_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentsRepoImplementation extends PaymentsRepo {
  final Ref _ref;

  PaymentsRepoImplementation(this._ref);

  late final PaymentsDataSource _dataSource =
  _ref.read(paymentsDataProvider);

  @override
  Future<ApiResult<List<Invoice>>> fetchInvoices(InvoiceParams params) {
    return dioInterceptor(() => _dataSource.fetchInvoice(params));
  }

  @override
  Future<ApiResult<PaymentIntent>> paymentInit(List<Invoice> invoices) {
    return dioInterceptor(() => _dataSource.paymentInit(invoices));
  }

  @override
  Future<ApiResult<Transaction>> paymentVerification(String ref) {
    return dioInterceptor(() => _dataSource.paymentVerification(ref));
  }

  @override
  Future<ApiResult<Payment>> fetchPaymentData() {
    return dioInterceptor(() => _dataSource.fetchPaymentData());
  }

}

final paymentsRepoProvider = Provider<PaymentsRepo>((ref) {
  return PaymentsRepoImplementation(ref);
});
