import 'package:mra/app/payments/data/data_source/payments_source.dart';
import 'package:mra/app/payments/data/models/invoice.dart';
import 'package:mra/app/payments/data/models/payment.dart';
import 'package:mra/app/payments/data/models/payment_intent.dart';
import 'package:mra/app/payments/data/models/transaction.dart';
import 'package:mra/app/payments/domain/params/invoice_params.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/services/api/api_client.dart';
import 'package:mra/src/res/values/constants/api_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentsDataSourceImplementation extends PaymentsDataSource {
  final Ref _ref;

  PaymentsDataSourceImplementation(this._ref);

  late final ApiClient _apiClient = _ref.read(apiClientProvider);

  @override
  Future<List<Invoice>> fetchInvoice(InvoiceParams params) async{
    final response = await _apiClient.get(kInvoiceRoute,
        queryParameters: params.toJson());
    return (response.data["data"]["list"] as List<dynamic>)
        .map((e) => Invoice.fromJson(e))
        .toList();
  }

  @override
  Future<PaymentIntent> paymentInit(List<Invoice> invoices) async{
    final response = await _apiClient.post(kPaymentInitApi,data: {
      "invoiceIds": invoices.map((e) => e.id).toList()
    });
    return PaymentIntent.fromMap(response.data["data"]);
  }

  @override
  Future<Transaction> paymentVerification(String ref) async{
    final response = await _apiClient.post(kPaymentVerifyApi,data: {
      "reference": ref
    });
    return Transaction.fromJson(response.data["data"]);
  }

  @override
  Future<Payment> fetchPaymentData() async{
    final response = await _apiClient.get(kInvoiceTransactionRoute);
    return Payment.fromJson(response.data["data"]);
  }

}

final paymentsDataProvider = Provider<PaymentsDataSource>((ref) {
  return PaymentsDataSourceImplementation(ref);
});