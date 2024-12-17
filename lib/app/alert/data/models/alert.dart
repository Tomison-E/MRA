import 'package:mra/app/alert/data/models/incident.dart';
import 'package:json_annotation/json_annotation.dart';

part 'alert.g.dart';

@JsonSerializable()
class Alert {
  final String id;
  final String description;
  final IncidentType type;
  final AlertStatus status;

  factory Alert.fromJson(Map<String, Object?> json) => _$AlertFromJson(json);

  Alert(this.id, this.description, this.type, this.status);

  Map<String, Object?> toJson() => _$AlertToJson(this);
}

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum AlertStatus { closed, active, pending }
