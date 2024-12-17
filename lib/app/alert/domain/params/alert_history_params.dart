import 'package:mra/app/alert/data/models/alert.dart';
import 'package:equatable/equatable.dart';

class AlertHistoryParams extends Equatable {
  final AlertStatus? status;
  final String estateId;
  final int page;
  final int limit;

  const AlertHistoryParams(this.status, this.estateId,
      [this.limit = 3, this.page = 1]);

  Map<String, dynamic> toMap() {
    return {
      if (status != null) "status": status!.name.toUpperCase(),
      "estateId": estateId,
      "limit": limit,
      "page": page
    };
  }

  AlertHistoryParams incrementPage() {
    return AlertHistoryParams(status, estateId, limit, page + 1);
  }

  @override
  List<Object?> get props => [status, estateId, limit];
}
