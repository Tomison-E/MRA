import 'package:mra/app/chat/data/models/chat_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat_message.g.dart';

@JsonSerializable()
class ChatMessage {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String message;
  final bool? readReceipt;
  final ChatUser sender;

  factory ChatMessage.fromJson(Map<String, Object?> json) =>
      _$ChatMessageFromJson(json);

  ChatMessage(this.id, this.createdAt, this.updatedAt, this.message,
      this.readReceipt, this.sender);

  Map<String, Object?> toJson() => _$ChatMessageToJson(this);
}
