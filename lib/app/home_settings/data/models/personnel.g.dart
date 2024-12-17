// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personnel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Personnel _$PersonnelFromJson(Map<String, dynamic> json) => Personnel(
      json['firstName'] as String,
      json['lastName'] as String,
      json['phoneNumber'] as String,
      $enumDecode(_$PersonnelTypeEnumMap, json['type']),
      json['id'] as String,
    );

Map<String, dynamic> _$PersonnelToJson(Personnel instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phoneNumber': instance.phoneNumber,
      'type': _$PersonnelTypeEnumMap[instance.type]!,
    };

const _$PersonnelTypeEnumMap = {
  PersonnelType.member: 'MEMBER',
  PersonnelType.staff: 'STAFF',
};
