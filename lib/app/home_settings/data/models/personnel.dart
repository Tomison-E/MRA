import 'package:json_annotation/json_annotation.dart';

part 'personnel.g.dart';

@JsonSerializable()
class Personnel {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final PersonnelType type;

  Personnel(
      this.firstName, this.lastName, this.phoneNumber, this.type, this.id);

  factory Personnel.fromJson(Map<String, Object?> json) =>
      _$PersonnelFromJson(json);

  Map<String, Object?> toJson() => _$PersonnelToJson(this);
}

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum PersonnelType { member, staff }
