import 'package:json_annotation/json_annotation.dart';

part 'announcement.g.dart';

@JsonSerializable()
class Announcement {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime? startDate;
  final DateTime? endDate;
  final AnnouncementType type;

  Announcement(this.id, this.title, this.description, this.type, this.createdAt,
      {this.startDate, this.endDate});

  factory Announcement.fromJson(Map<String, Object?> json) =>
      _$AnnouncementFromJson(json);

  Map<String, Object?> toJson() => _$AnnouncementToJson(this);
}

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum AnnouncementType { general }
