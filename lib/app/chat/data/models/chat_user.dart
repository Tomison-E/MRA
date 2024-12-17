import 'package:mra/app/authentication/data/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_user.g.dart';

@JsonSerializable()
class ChatUser {
  final String id;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String phoneNumber;
  final String? email;
  final UserType type;
  final String? profileImageUrl;

  String get fullName => '$firstName $lastName';
  factory ChatUser.fromJson(Map<String, Object?> json) =>
      _$ChatUserFromJson(json);

  ChatUser(
      this.id,
      this.firstName,
      this.lastName,
      this.createdAt,
      this.updatedAt,
      this.phoneNumber,
      this.email,
      this.type,
      this.profileImageUrl);

  Map<String, Object?> toJson() => _$ChatUserToJson(this);
}
