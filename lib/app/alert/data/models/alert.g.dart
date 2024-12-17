// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alert.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alert _$AlertFromJson(Map<String, dynamic> json) => Alert(
      json['id'] as String,
      json['description'] as String,
      $enumDecode(_$IncidentTypeEnumMap, json['type']),
      $enumDecode(_$AlertStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$AlertToJson(Alert instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'type': _$IncidentTypeEnumMap[instance.type]!,
      'status': _$AlertStatusEnumMap[instance.status]!,
    };

const _$IncidentTypeEnumMap = {
  IncidentType.flooding: 'FLOODING',
  IncidentType.theft: 'THEFT',
  IncidentType.loitering: 'LOITERING',
  IncidentType.fire: 'FIRE',
  IncidentType.health: 'HEALTH',
  IncidentType.other: 'OTHER',
};

const _$AlertStatusEnumMap = {
  AlertStatus.closed: 'CLOSED',
  AlertStatus.active: 'ACTIVE',
  AlertStatus.pending: 'PENDING',
};
