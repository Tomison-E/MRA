import 'package:mra/app/chat/data/models/chat_message.dart';
import 'package:mra/app/chat/data/models/chat_user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class Chat {
  final String id;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final ChatUser user1;
  final ChatUser user2;
  final List<ChatMessage> chatMessages;

  factory Chat.fromJson(Map<String, Object?> json) => _$ChatFromJson(json);

  Chat(this.id, this.createdAt, this.updatedAt, this.user1, this.user2,
      this.chatMessages);

  Map<String, Object?> toJson() => _$ChatToJson(this);
}
