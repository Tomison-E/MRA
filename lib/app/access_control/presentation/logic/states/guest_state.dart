import 'dart:async';

import 'package:mra/app/access_control/data/models/guest.dart';
import 'package:mra/app/access_control/domain/params/guest_history_params.dart';
import 'package:mra/app/access_control/domain/params/guest_params.dart';
import 'package:mra/app/access_control/domain/use_cases/access_control_use_cases.dart';
import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/core/service_result/service_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuestState extends AsyncNotifier<List<Guest>> {
  @override
  FutureOr<List<Guest>> build() {
    return fetchInvitedGuests();
  }

  FutureOr<List<Guest>> fetchInvitedGuests([GuestHistoryParams? params]) async {
    return (await ref.read(
      fetchGuestHistoryUseCaseProvider(
        params ??
            GuestHistoryParams(GuestStatus.pending,
                ref.read(userStateProvider)!.estate.id, true),
      ),
    ))
        .extract();
  }

  Future<ApiResult> inviteGuest(GuestParams params) async {
    final members = state.asData?.value;
    final value = await ref.read(inviteGuestUseCaseProvider(params));
    value.when(
      success: (value) async {
        state = const AsyncLoading();
        state = AsyncData(
          await fetchInvitedGuests(),
        );
      },
      apiFailure: (_, __) => state = AsyncData(members ?? []),
    );
    return value;
  }
}

final guestStateProvider =
    AsyncNotifierProvider<GuestState, List<Guest>>(() => GuestState());

final guestHistoryProvider =
    FutureProviderFamily<List<Guest>, GuestHistoryParams>((ref, arg) =>
        ref.read(guestStateProvider.notifier).fetchInvitedGuests(arg));
