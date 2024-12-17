// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GuestHistory _$GuestHistoryFromJson(Map<String, dynamic> json) => GuestHistory(
      Guest.fromJson(json['guest'] as Map<String, dynamic>),
      DateTime.parse(json['entryTime'] as String),
      DateTime.parse(json['exitTime'] as String),
      $enumDecode(_$GuestStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$GuestHistoryToJson(GuestHistory instance) =>
    <String, dynamic>{
      'guest': instance.guest,
      'entryTime': instance.entryTime.toIso8601String(),
      'exitTime': instance.exitTime.toIso8601String(),
      'status': _$GuestStatusEnumMap[instance.status]!,
    };

const _$GuestStatusEnumMap = {
  GuestStatus.checkedOut: 'CHECKED_OUT',
  GuestStatus.checkedIn: 'CHECKED_IN',
  GuestStatus.pending: 'PENDING',
};
