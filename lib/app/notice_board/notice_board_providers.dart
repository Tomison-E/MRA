import 'package:mra/app/notice_board/data/data_source/notice_board_source.dart';
import 'package:mra/app/notice_board/data/data_source/notice_board_source_impl.dart';
import 'package:mra/app/notice_board/data/models/announcement.dart';
import 'package:mra/app/notice_board/data/repo_impl/notice_board_repo_impl.dart';
import 'package:mra/app/notice_board/domain/repo/notice_board_repo.dart';
import 'package:mra/app/notice_board/domain/use_cases/use_cases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final noticeBoardDataProvider = Provider<NoticeBoardDataSource>((ref) {
  return NoticeBoardDataSourceImplementation(ref);
});

final noticeBoardRepoProvider = Provider<NoticeBoardRepo>((ref) {
  return NoticeBoardRepoImplementation(ref);
});

final announcementStateProvider = FutureProvider<List<Announcement>>(
    (ref) async =>
        (await ref.read(fetchAnnouncementsUseCaseProvider)).extract());
