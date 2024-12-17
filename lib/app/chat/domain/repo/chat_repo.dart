import 'package:mra/app/chat/data/models/chat.dart';
import 'package:mra/app/chat/data/models/chat_message.dart';
import 'package:mra/core/service_result/service_result.dart';

abstract class ChatRepo {
  Future<ApiResult<Chat>> startChat(
      ({String senderId, String receiverId, String message}) params);
  Future<ApiResult<bool>> sendMessage(
      ({String senderId, String chatId, String message}) params);
  Future<ApiResult<List<ChatMessage>>> getChatMessages(
      ({String chatId, int page, int limit}) params);
  Future<ApiResult<List<Chat>>> getChats();
}
