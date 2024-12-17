// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['firstName'] as String,
      json['lastName'] as String,
      json['_id'] as String,
      json['phoneNumber'] as String,
      json['profileImageUrl'] as String?,
      json['hasPin'] as bool,
      (json['addresses'] as List<dynamic>)
          .map((e) => HouseHold.fromJson(e as Map<String, dynamic>))
          .toList(),
      $enumDecodeNullable(_$CountryEnumMap, json['countryCode']) ?? Country.ng,
      $enumDecode(_$UserTypeEnumMap, json['role']),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      '_id': instance.id,
      'phoneNumber': instance.phoneNumber,
      'profileImageUrl': instance.profileImageUrl,
      'role': _$UserTypeEnumMap[instance.role]!,
      'hasPin': instance.hasPin,
      'addresses': instance.addresses,
      'countryCode': _$CountryEnumMap[instance.countryCode]!,
    };

const _$CountryEnumMap = {
  Country.ng: 'ng',
  Country.gh: 'gh',
};

const _$UserTypeEnumMap = {
  UserType.resident: 'resident',
  UserType.security: 'SECURITY',
  UserType.estateManager: 'ESTATE_MANAGER',
};
