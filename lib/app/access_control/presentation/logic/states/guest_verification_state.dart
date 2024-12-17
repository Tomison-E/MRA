import 'dart:async';

import 'package:mra/app/access_control/data/models/guest.dart';
import 'package:mra/app/access_control/domain/params/guest_update_params.dart';
import 'package:mra/app/access_control/domain/use_cases/access_control_use_cases.dart';
import 'package:mra/core/service_result/service_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuestVerificationState extends FamilyAsyncNotifier<Guest?, String?> {
  @override
  FutureOr<Guest?> build(arg) async {
    return fetchGuestByCode();
  }

  FutureOr<Guest?> fetchGuestByCode() async {
    if (arg == null) return null;
    return (await ref.read(guestVerificationUseCaseProvider(arg!))).extract();
  }

  Future<ApiResult<bool>> updateGuest(GuestUpdateParams params) async {
    final value = await ref.read(updateGuestUseCaseProvider(params));
    value.when(
      success: (value) => state = const AsyncData(null),
      apiFailure: (_, __) {},
    );
    return value;
  }
}

final guestVerificationStateProvider =
    AsyncNotifierProviderFamily<GuestVerificationState, Guest?, String?>(
        () => GuestVerificationState());
