import 'dart:async';

import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/chat/data/models/chat.dart';
import 'package:mra/app/chat/data/models/chat_message.dart';
import 'package:mra/app/chat/domain/use_cases/use_cases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatState extends AsyncNotifier<List<Chat>> {
  ChatState();

  Future<List<Chat>> _getChats() async {
    return (await ref.read(getChatsUseCaseProvider)).extract();
  }

  void initChat(String message) async {
    final user = ref.read(userStateProvider)!;
    final responses = (
      await ref.read(
        startChartUseCaseProvider(
          (
            receiverId: user.estate.managerId,
            senderId: user.id,
            message: message
          ),
        ),
      ),
    );
    final value = responses.$1.asyncGuard();
    state = value.when(
        data: (data) => AsyncData([data]),
        error: (error, trace) => AsyncError(error, trace),
        loading: () => const AsyncLoading());
  }

  void updateChatMessages(List<ChatMessage> messages) async {
    state.whenData((value) async {
      value.first.chatMessages.addAll(messages);
      state = AsyncData(value);
    });
  }

  void addChatMessage(ChatMessage message) async {
    state.whenData((value) async {
      value.first.chatMessages.insert(0, message);
      state = AsyncData(value);
    });
  }

  @override
  FutureOr<List<Chat>> build() async {
    return _getChats();
  }
}
