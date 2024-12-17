import 'package:mra/app/payments/data/models/transaction.dart';
import 'package:mra/app/payments/data/repo_impl/payments_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final verifyPaymentProvider = FutureProviderFamily<Transaction, String>((ref,
        arg) async =>
    (await ref.read(paymentsRepoProvider).paymentVerification(arg)).extract());
