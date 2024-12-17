import 'package:mra/app/notice_board/data/models/announcement.dart';
import 'package:mra/core/service_result/service_result.dart';

abstract class NoticeBoardRepo {
  Future<ApiResult<List<Announcement>>> getAnnouncement(String estateId);
}
