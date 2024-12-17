import 'package:mra/app/alert/data/models/alert.dart';
import 'package:mra/app/alert/domain/params/alert_history_params.dart';
import 'package:mra/app/alert/domain/params/incident_params.dart';
import 'package:mra/app/alert/domain/params/update_alert_params.dart';
import 'package:mra/core/service_result/service_result.dart';

abstract class AlertRepo {
  Future<ApiResult<bool>> sendAlert(IncidentParams params);
  Future<ApiResult<List<Alert>>> getAlerts(AlertHistoryParams params);
  Future<ApiResult<bool>> updateAlert(UpdateAlertParams params);
}
