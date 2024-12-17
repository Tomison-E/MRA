import 'package:mra/app/chat/chat_providers.dart';
import 'package:mra/app/chat/data/data_source/chat_source.dart';
import 'package:mra/app/chat/data/models/chat.dart';
import 'package:mra/app/chat/data/models/chat_message.dart';
import 'package:mra/app/chat/domain/repo/chat_repo.dart';
import 'package:mra/core/helpers/dio_interceptor.dart';
import 'package:mra/core/service_result/src/api_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRepoImplementation extends ChatRepo {
  final Ref _ref;

  ChatRepoImplementation(this._ref);

  late final ChatDataSource _dataSource = _ref.read(chatDataProvider);

  @override
  Future<ApiResult<List<ChatMessage>>> getChatMessages(
      ({String chatId, int limit, int page}) params) {
    return dioInterceptor(() => _dataSource.getChatMessages(params));
  }

  @override
  Future<ApiResult<bool>> sendMessage(
      ({String chatId, String message, String senderId}) params) {
    return dioInterceptor(() => _dataSource.sendMessage(params));
  }

  @override
  Future<ApiResult<Chat>> startChat(
      ({String message, String receiverId, String senderId}) params) {
    return dioInterceptor(() => _dataSource.startChat(params));
  }

  @override
  Future<ApiResult<List<Chat>>> getChats() {
    return dioInterceptor(() => _dataSource.getChats());
  }
}
