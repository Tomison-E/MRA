import 'package:json_annotation/json_annotation.dart';

part 'service_staff.g.dart';

@JsonSerializable()
class ServiceStaff {
  final String? profileImg;
  final String name;
  final String phoneNumber;
  final int rating;
  final ServiceType type;
  final int totalRating;

  const ServiceStaff(this.type, this.name, this.phoneNumber,
      {this.rating = 5, this.totalRating = 20, this.profileImg});

  factory ServiceStaff.fromJson(Map<String, Object?> json) =>
      _$ServiceStaffFromJson(json);

  Map<String, Object?> toJson() => _$ServiceStaffToJson(this);
}

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum ServiceType { ac, plumbing, carpentry }
