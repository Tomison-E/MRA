import 'package:mra/app/alert/data/models/incident.dart';
import 'package:equatable/equatable.dart';

class IncidentParams extends Equatable {
  final IncidentType type;
  final String description;
  final String householdId;

  const IncidentParams(this.type, this.description, this.householdId);

  toJson() => {
        "type": type.name.toUpperCase(),
        "description": description,
        "householdId": householdId
      };

  @override
  List<Object?> get props => [type, description, householdId];
}
