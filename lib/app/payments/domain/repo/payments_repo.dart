import 'package:mra/app/payments/data/models/invoice.dart';
import 'package:mra/app/payments/data/models/payment.dart';
import 'package:mra/app/payments/data/models/payment_intent.dart';
import 'package:mra/app/payments/data/models/transaction.dart';
import 'package:mra/app/payments/domain/params/invoice_params.dart';
import 'package:mra/core/service_result/service_result.dart';

abstract class PaymentsRepo{
  Future<ApiResult<List<Invoice>>> fetchInvoices(InvoiceParams params);
  Future<ApiResult<PaymentIntent>> paymentInit(List<Invoice> invoices);
  Future<ApiResult<Payment>> fetchPaymentData();
  Future<ApiResult<Transaction>> paymentVerification(String ref);
}