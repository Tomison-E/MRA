import 'dart:async';

import 'package:mra/app/alert/data/models/alert.dart';
import 'package:mra/app/alert/domain/params/alert_history_params.dart';
import 'package:mra/app/alert/domain/params/update_alert_params.dart';
import 'package:mra/app/alert/domain/use_cases/use_cases.dart';
import 'package:mra/core/service_result/src/api_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InActiveAlertState
    extends FamilyAsyncNotifier<List<Alert>, AlertHistoryParams> {
  @override
  FutureOr<List<Alert>> build(arg) async {
    return fetchInactiveAlerts();
  }

  FutureOr<List<Alert>> fetchInactiveAlerts() async {
    return (await ref.read(fetchAlertsUseCaseProvider(arg))).extract();
  }

  Future<ApiResult<bool>> respondToAlert(String id) async {
    //final members = state.asData?.value;
    final value = await ref.read(
        updateAlertsUseCaseProvider(UpdateAlertParams(AlertStatus.active, id)));
    value.when(
        success: (value) async {
          state = const AsyncLoading();
          state = AsyncData(
            await fetchInactiveAlerts(),
          );
        },
        apiFailure: (_, __) {});
    return value;
  }

  Future<ApiResult<List<Alert>>> fetchMoreAlerts() async {
    final members = state.value;
    final value =
        await ref.read(fetchAlertsUseCaseProvider(arg.incrementPage()));
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

final inactiveAlertStateProvider = AsyncNotifierProviderFamily<
    InActiveAlertState,
    List<Alert>,
    AlertHistoryParams>(() => InActiveAlertState());
