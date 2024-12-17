import 'package:json_annotation/json_annotation.dart';

part 'guest.g.dart';

@JsonSerializable()
class Guest {
  final String id;
  final String name;
  final String phoneNumber;
  final DateTime? checkInTime;
  final String accessCode;
  final DateTime createdAt;
  final DateTime? checkOutTime;
  final GuestStatus status;

  factory Guest.fromJson(Map<String, Object?> json) => _$GuestFromJson(json);

  Guest(this.id, this.name, this.phoneNumber, this.checkInTime,
      this.checkOutTime, this.status, this.createdAt, this.accessCode);

  Map<String, Object?> toJson() => _$GuestToJson(this);

  bool get yetToCheckout => checkOutTime?.isAfter(DateTime.now()) ?? true;
}

@JsonEnum(fieldRename: FieldRename.screamingSnake)
enum GuestStatus { checkedOut, checkedIn, pending }

extension GuestStatusName on GuestStatus {
  String get stringify {
    switch (this) {
      case GuestStatus.checkedOut:
        return "CHECKED_OUT";
      case GuestStatus.checkedIn:
        return "CHECKED_IN";
      case GuestStatus.pending:
        return 'PENDING';
    }
  }
}
