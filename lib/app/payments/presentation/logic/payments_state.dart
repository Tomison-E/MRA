import 'dart:async';
import 'package:mra/app/payments/data/models/payment.dart';
import 'package:mra/app/payments/domain/use_cases/use_cases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PaymentState extends AsyncNotifier<Payment> {
  @override
  FutureOr<Payment> build() async {
    return fetchPaymentData();
  }

  FutureOr<Payment> fetchPaymentData() async {
    return (await ref.read(fetchPaymentDataUseCaseProvider)).extract();
  }

}

final paymentStateProvider =
AsyncNotifierProvider<PaymentState, Payment>(
        () => PaymentState());
