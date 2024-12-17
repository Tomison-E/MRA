import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/notice_board/data/models/announcement.dart';
import 'package:mra/app/notice_board/notice_board_providers.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/service_result/service_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final fetchAnnouncementsUseCaseProvider =
    AutoDisposeProvider<Future<ApiResult<List<Announcement>>>>(
  (ref) => UseCase<List<Announcement>>().call(() => ref
      .read(noticeBoardRepoProvider)
      .getAnnouncement(ref.read(userStateProvider)!.estate.id)),
);
