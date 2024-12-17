import 'package:mra/app/alert/data/models/alert.dart';
import 'package:equatable/equatable.dart';

class UpdateAlertParams extends Equatable {
  final AlertStatus status;
  final String alertId;

  const UpdateAlertParams(this.status, this.alertId);

  toJson() => {"alertReportId": alertId, "status": status.name.toUpperCase()};

  @override
  List<Object?> get props => [alertId];
}
