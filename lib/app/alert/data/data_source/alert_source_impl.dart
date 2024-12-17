import 'package:mra/app/alert/data/data_source/alert_source.dart';
import 'package:mra/app/alert/data/models/alert.dart';
import 'package:mra/app/alert/domain/params/alert_history_params.dart';
import 'package:mra/app/alert/domain/params/incident_params.dart';
import 'package:mra/app/alert/domain/params/update_alert_params.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/services/api/api_client.dart';
import 'package:mra/src/res/values/constants/api_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlertDataSourceImplementation extends AlertDataSource {
  final Ref _ref;

  AlertDataSourceImplementation(this._ref);

  late final ApiClient _apiClient = _ref.read(apiClientProvider);

  @override
  Future<bool> sendAlert(IncidentParams params) async {
    await _apiClient.post(kAlertReportApi, data: params.toJson());
    return true;
  }

  @override
  Future<List<Alert>> getAlerts(AlertHistoryParams params) async {
    final response = await _apiClient.get(kAlertReportsApi,
        queryParameters: params.toMap());
    return (response.data["data"]["list"] as List<dynamic>)
        .map((e) => Alert.fromJson(e))
        .toList();
  }

  @override
  Future<bool> updateAlert(UpdateAlertParams params) async {
    await _apiClient.put(kAlertReportApi, data: params.toJson());
    return true;
  }
}

final alertDataProvider = Provider<AlertDataSource>((ref) {
  return AlertDataSourceImplementation(ref);
});
