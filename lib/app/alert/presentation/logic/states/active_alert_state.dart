import 'dart:async';

import 'package:mra/app/alert/data/models/alert.dart';
import 'package:mra/app/alert/domain/params/alert_history_params.dart';
import 'package:mra/app/alert/domain/params/update_alert_params.dart';
import 'package:mra/app/alert/domain/use_cases/use_cases.dart';
import 'package:mra/core/service_result/service_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveAlertState
    extends FamilyAsyncNotifier<List<Alert>, AlertHistoryParams> {
  @override
  FutureOr<List<Alert>> build(arg) async {
    return fetchActiveAlerts();
  }

  FutureOr<List<Alert>> fetchActiveAlerts() async {
    return (await ref.read(fetchAlertsUseCaseProvider(arg))).extract();
  }

  Future<ApiResult<bool>> closeAlert(String id) async {
    //final members = state.asData?.value;
    final value = await ref.read(
        updateAlertsUseCaseProvider(UpdateAlertParams(AlertStatus.closed, id)));
    value.when(
      success: (value) async {
        state = const AsyncLoading();
        state = AsyncData(
          await fetchActiveAlerts(),
        );
      },
      apiFailure: (_, __) {},
    );
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

final activeAlertStateProvider = AsyncNotifierProviderFamily<ActiveAlertState,
    List<Alert>, AlertHistoryParams>(() => ActiveAlertState());
