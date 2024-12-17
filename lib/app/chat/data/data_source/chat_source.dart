import 'package:mra/app/chat/data/models/chat.dart';
import 'package:mra/app/chat/data/models/chat_message.dart';

abstract class ChatDataSource {
  Future<Chat> startChat(
      ({String senderId, String receiverId, String message}) params);
  Future<bool> sendMessage(
      ({String senderId, String chatId, String message}) params);
  Future<List<ChatMessage>> getChatMessages(
      ({String chatId, int page, int limit}) params);
  Future<List<Chat>> getChats();
}
