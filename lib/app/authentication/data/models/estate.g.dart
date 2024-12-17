// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'estate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Estate _$EstateFromJson(Map<String, dynamic> json) => Estate(
      json['name'] as String,
      json['address'] as String,
      (json['households'] as List<dynamic>)
          .map((e) => HouseHold.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['id'] as String,
      json['managerId'] as String,
    );

Map<String, dynamic> _$EstateToJson(Estate instance) => <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'households': instance.households,
      'id': instance.id,
      'managerId': instance.managerId,
    };

HouseHold _$HouseHoldFromJson(Map<String, dynamic> json) => HouseHold(
      json['houseNumber'] as String,
      json['householdId'] as String,
    );

Map<String, dynamic> _$HouseHoldToJson(HouseHold instance) => <String, dynamic>{
      'houseNumber': instance.houseNumber,
      'householdId': instance.householdId,
    };
