// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatUser _$ChatUserFromJson(Map<String, dynamic> json) => ChatUser(
      json['id'] as String,
      json['firstName'] as String,
      json['lastName'] as String,
      DateTime.parse(json['createdAt'] as String),
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      json['phoneNumber'] as String,
      json['email'] as String?,
      $enumDecode(_$UserTypeEnumMap, json['type']),
      json['profileImageUrl'] as String?,
    );

Map<String, dynamic> _$ChatUserToJson(ChatUser instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'phoneNumber': instance.phoneNumber,
      'email': instance.email,
      'type': _$UserTypeEnumMap[instance.type]!,
      'profileImageUrl': instance.profileImageUrl,
    };

const _$UserTypeEnumMap = {
  UserType.resident: 'RESIDENT',
  UserType.security: 'SECURITY',
  UserType.estateManager: 'ESTATE_MANAGER',
};
