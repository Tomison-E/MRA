import 'package:mra/app/notice_board/data/data_source/notice_board_source.dart';
import 'package:mra/app/notice_board/data/models/announcement.dart';
import 'package:mra/app/notice_board/domain/repo/notice_board_repo.dart';
import 'package:mra/app/notice_board/notice_board_providers.dart';
import 'package:mra/core/helpers/dio_interceptor.dart';
import 'package:mra/core/service_result/src/api_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoticeBoardRepoImplementation extends NoticeBoardRepo {
  final Ref _ref;

  NoticeBoardRepoImplementation(this._ref);

  late final NoticeBoardDataSource _dataSource =
      _ref.read(noticeBoardDataProvider);

  @override
  Future<ApiResult<List<Announcement>>> getAnnouncement(String estateId) {
    return dioInterceptor(() => _dataSource.getAnnouncements(estateId));
  }
}
