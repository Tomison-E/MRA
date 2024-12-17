import 'package:mra/app/chat/data/data_source/chat_source.dart';
import 'package:mra/app/chat/data/models/chat.dart';
import 'package:mra/app/chat/data/models/chat_message.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/services/api/api_client.dart';
import 'package:mra/src/res/values/constants/api_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatDataSourceImplementation extends ChatDataSource {
  final Ref _ref;

  ChatDataSourceImplementation(this._ref);

  late final ApiClient _apiClient = _ref.read(apiClientProvider);

  @override
  Future<List<ChatMessage>> getChatMessages(
      ({String chatId, int page, int limit}) params) async {
    final response = await _apiClient.get(
        "$kChatRoute/${params.chatId}/messages",
        queryParameters: {"page": params.page, "limit": params.limit});
    return (response.data["data"]["list"] as List<dynamic>)
        .map((e) => ChatMessage.fromJson(e))
        .toList();
  }

  @override
  Future<bool> sendMessage(
      ({String chatId, String message, String senderId}) params) async {
       await _apiClient.post("$kChatRoute/messages", data: {
      "chatId": params.chatId,
      "senderId": params.senderId,
      "message": params.message
    });

    return true;
  }

  @override
  Future<Chat> startChat(
      ({String message, String receiverId, String senderId}) params) async {
    final response = await _apiClient.post(kChatRoute, data: {
      "senderId": params.senderId,
      "recieverId": params.receiverId,
      "firstMessage": params.message
    });

    return response.data["data"];
  }

  @override
  Future<List<Chat>> getChats() async {
    final response = await _apiClient.get(kChatsRoute);
    return (response.data["data"] as List<dynamic>)
        .map((e) => Chat.fromJson(e))
        .toList();
  }
}
