import 'package:mra/app/access_control/data/models/guest.dart';
import 'package:json_annotation/json_annotation.dart';

part 'guest_history.g.dart';

@JsonSerializable()
class GuestHistory {
  final Guest guest;
  final DateTime entryTime;
  final DateTime exitTime;
  final GuestStatus status;

  GuestHistory(this.guest, this.entryTime, this.exitTime, this.status);

  factory GuestHistory.fromJson(Map<String, Object?> json) =>
      _$GuestHistoryFromJson(json);

  Map<String, Object?> toJson() => _$GuestHistoryToJson(this);

  bool get yetToCheckout => exitTime.isAfter(DateTime.now());
}
