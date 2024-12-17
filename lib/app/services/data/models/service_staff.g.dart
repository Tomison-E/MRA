// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_staff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceStaff _$ServiceStaffFromJson(Map<String, dynamic> json) => ServiceStaff(
      $enumDecode(_$ServiceTypeEnumMap, json['type']),
      json['name'] as String,
      json['phoneNumber'] as String,
      rating: (json['rating'] as num?)?.toInt() ?? 5,
      totalRating: (json['totalRating'] as num?)?.toInt() ?? 20,
      profileImg: json['profileImg'] as String?,
    );

Map<String, dynamic> _$ServiceStaffToJson(ServiceStaff instance) =>
    <String, dynamic>{
      'profileImg': instance.profileImg,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'rating': instance.rating,
      'type': _$ServiceTypeEnumMap[instance.type]!,
      'totalRating': instance.totalRating,
    };

const _$ServiceTypeEnumMap = {
  ServiceType.ac: 'AC',
  ServiceType.plumbing: 'PLUMBING',
  ServiceType.carpentry: 'CARPENTRY',
};
