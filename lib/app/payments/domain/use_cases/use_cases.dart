import 'package:mra/app/payments/data/models/invoice.dart';
import 'package:mra/app/payments/data/models/payment.dart';
import 'package:mra/app/payments/data/models/payment_intent.dart';
import 'package:mra/app/payments/data/repo_impl/payments_repo_impl.dart';
import 'package:mra/app/payments/domain/params/invoice_params.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/service_result/service_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchInvoicesUseCaseProvider =
AutoDisposeProviderFamily<Future<ApiResult<List<Invoice>>>,InvoiceParams>(
      (ref,arg) => UseCase<List<Invoice>>().call(() => ref
      .read(paymentsRepoProvider)
      .fetchInvoices(arg)),
);

final fetchPaymentDataUseCaseProvider =
AutoDisposeProvider<Future<ApiResult<Payment>>>(
      (ref) => UseCase<Payment>().call(() => ref
      .read(paymentsRepoProvider)
      .fetchPaymentData()),
);

final initPaymentUseCaseProvider =
AutoDisposeProviderFamily<Future<ApiResult<PaymentIntent>>,List<Invoice>>(
      (ref,arg) => UseCase<PaymentIntent>().call(() => ref
      .read(paymentsRepoProvider).paymentInit(arg)),
);

