import 'package:mra/app/chat/chat_providers.dart';
import 'package:mra/app/chat/data/models/chat.dart';
import 'package:mra/app/chat/data/models/chat_message.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/service_result/service_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final startChartUseCaseProvider = AutoDisposeProviderFamily<
    Future<ApiResult<Chat>>,
    ({String senderId, String receiverId, String message})>(
  (ref, arg) =>
      UseCase<Chat>().call(() => ref.read(chatRepoProvider).startChat(arg)),
);

final sendMessageUseCaseProvider = AutoDisposeProviderFamily<
    Future<ApiResult<bool>>,
    ({String senderId, String chatId, String message})>(
  (ref, arg) =>
      UseCase<bool>().call(() => ref.read(chatRepoProvider).sendMessage(arg)),
);

final getMessagesUseCaseProvider = AutoDisposeProviderFamily<
    Future<ApiResult<List<ChatMessage>>>,
    ({String chatId, int page, int limit})>(
  (ref, arg) => UseCase<List<ChatMessage>>()
      .call(() => ref.read(chatRepoProvider).getChatMessages(arg)),
);

final getChatsUseCaseProvider =
    AutoDisposeProvider<Future<ApiResult<List<Chat>>>>(
  (ref) =>
      UseCase<List<Chat>>().call(() => ref.read(chatRepoProvider).getChats()),
);
