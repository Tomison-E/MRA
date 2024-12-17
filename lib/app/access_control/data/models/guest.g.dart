// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'guest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Guest _$GuestFromJson(Map<String, dynamic> json) => Guest(
      json['id'] as String,
      json['name'] as String,
      json['phoneNumber'] as String,
      json['checkInTime'] == null
          ? null
          : DateTime.parse(json['checkInTime'] as String),
      json['checkOutTime'] == null
          ? null
          : DateTime.parse(json['checkOutTime'] as String),
      $enumDecode(_$GuestStatusEnumMap, json['status']),
      DateTime.parse(json['createdAt'] as String),
      json['accessCode'] as String,
    );

Map<String, dynamic> _$GuestToJson(Guest instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'checkInTime': instance.checkInTime?.toIso8601String(),
      'accessCode': instance.accessCode,
      'createdAt': instance.createdAt.toIso8601String(),
      'checkOutTime': instance.checkOutTime?.toIso8601String(),
      'status': _$GuestStatusEnumMap[instance.status]!,
    };

const _$GuestStatusEnumMap = {
  GuestStatus.checkedOut: 'CHECKED_OUT',
  GuestStatus.checkedIn: 'CHECKED_IN',
  GuestStatus.pending: 'PENDING',
};
