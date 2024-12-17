import 'package:mra/app/alert/data/models/alert.dart';
import 'package:mra/app/alert/domain/params/alert_history_params.dart';
import 'package:mra/app/alert/domain/params/incident_params.dart';
import 'package:mra/app/alert/domain/params/update_alert_params.dart';

abstract class AlertDataSource {
  Future<bool> sendAlert(IncidentParams params);
  Future<List<Alert>> getAlerts(AlertHistoryParams params);
  Future<bool> updateAlert(UpdateAlertParams params);
}
