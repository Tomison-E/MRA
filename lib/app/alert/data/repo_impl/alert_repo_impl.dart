import 'package:mra/app/alert/data/data_source/alert_source.dart';
import 'package:mra/app/alert/data/data_source/alert_source_impl.dart';
import 'package:mra/app/alert/data/models/alert.dart';
import 'package:mra/app/alert/domain/params/alert_history_params.dart';
import 'package:mra/app/alert/domain/params/incident_params.dart';
import 'package:mra/app/alert/domain/params/update_alert_params.dart';
import 'package:mra/app/alert/domain/repo/alert_repo.dart';
import 'package:mra/core/helpers/dio_interceptor.dart';
import 'package:mra/core/service_result/src/api_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlertRepoImplementation extends AlertRepo {
  final Ref _ref;

  AlertRepoImplementation(this._ref);

  late final AlertDataSource _dataSource = _ref.read(alertDataProvider);

  @override
  Future<ApiResult<bool>> sendAlert(IncidentParams params) {
    return dioInterceptor(() => _dataSource.sendAlert(params));
  }

  @override
  Future<ApiResult<List<Alert>>> getAlerts(AlertHistoryParams params) {
    return dioInterceptor(() => _dataSource.getAlerts(params));
  }

  @override
  Future<ApiResult<bool>> updateAlert(UpdateAlertParams params) {
    return dioInterceptor(() => _dataSource.updateAlert(params));
  }
}

final alertRepoProvider = Provider<AlertRepo>((ref) {
  return AlertRepoImplementation(ref);
});
