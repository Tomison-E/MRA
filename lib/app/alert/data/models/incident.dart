import 'package:mra/src/extensions/strings.dart';
import 'package:mra/src/res/assets/assets.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum IncidentType { flooding, theft, loitering, fire, health, other }

extension IncidentTypeExt on IncidentType {
  String get iconPath {
    switch (this) {
      case IncidentType.flooding:
        return kFloodingSvg;
      case IncidentType.theft:
        return kTheftSvg;
      case IncidentType.loitering:
        return kLoiteringSvg;
      case IncidentType.fire:
        return kFireSvg;
      case IncidentType.health:
        return kHealthSvg;
      case IncidentType.other:
        return kOtherIncidentSvg;
    }
  }

  String get capsName => name.capitalize;
}
