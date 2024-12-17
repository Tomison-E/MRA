import 'package:mra/app/notice_board/data/models/announcement.dart';

abstract class NoticeBoardDataSource {
  Future<List<Announcement>> getAnnouncements(String estateId);
}
