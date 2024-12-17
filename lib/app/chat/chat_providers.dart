import 'package:mra/app/chat/data/data_source/chat_source.dart';
import 'package:mra/app/chat/data/data_source/chat_source_impl.dart';
import 'package:mra/app/chat/data/models/chat.dart';
import 'package:mra/app/chat/data/repo_impl/chat_repo_impl.dart';
import 'package:mra/app/chat/domain/repo/chat_repo.dart';
import 'package:mra/app/chat/presentation/logic/states/chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatDataProvider = Provider<ChatDataSource>((ref) {
  return ChatDataSourceImplementation(ref);
});

final chatRepoProvider = Provider<ChatRepo>((ref) {
  return ChatRepoImplementation(ref);
});

final chatStateProvider =
    AsyncNotifierProvider<ChatState, List<Chat>>(() => ChatState());
