import 'package:mra/app/payments/data/models/invoice.dart';
import 'package:mra/app/payments/data/models/payment.dart';
import 'package:mra/app/payments/data/models/payment_intent.dart';
import 'package:mra/app/payments/data/models/transaction.dart';
import 'package:mra/app/payments/domain/params/invoice_params.dart';

abstract class PaymentsDataSource{
  Future<List<Invoice>> fetchInvoice(InvoiceParams params);
  Future<Payment> fetchPaymentData();
  Future<PaymentIntent> paymentInit(List<Invoice> invoices);
  Future<Transaction> paymentVerification(String ref);
}