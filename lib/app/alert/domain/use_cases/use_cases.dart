import 'package:mra/app/alert/data/models/alert.dart';
import 'package:mra/app/alert/data/repo_impl/alert_repo_impl.dart';
import 'package:mra/app/alert/domain/params/alert_history_params.dart';
import 'package:mra/app/alert/domain/params/incident_params.dart';
import 'package:mra/app/alert/domain/params/update_alert_params.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/service_result/service_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sendAlertUseCaseProvider =
    AutoDisposeProviderFamily<Future<ApiResult<bool>>, IncidentParams>(
  (ref, arg) =>
      UseCase<bool>().call(() => ref.read(alertRepoProvider).sendAlert(arg)),
);

final fetchAlertsUseCaseProvider = AutoDisposeProviderFamily<
    Future<ApiResult<List<Alert>>>, AlertHistoryParams>((ref, arg) {
  return UseCase<List<Alert>>().call(
    () => ref.read(alertRepoProvider).getAlerts(arg),
  );
});

final updateAlertsUseCaseProvider =
    AutoDisposeProviderFamily<Future<ApiResult<bool>>, UpdateAlertParams>(
        (ref, arg) {
  return UseCase<bool>().call(
    () => ref.read(alertRepoProvider).updateAlert(arg),
  );
});
