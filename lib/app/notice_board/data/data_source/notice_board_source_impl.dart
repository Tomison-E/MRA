import 'package:mra/app/notice_board/data/data_source/notice_board_source.dart';
import 'package:mra/app/notice_board/data/models/announcement.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/services/api/api_client.dart';
import 'package:mra/src/res/values/constants/api_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NoticeBoardDataSourceImplementation extends NoticeBoardDataSource {
  final Ref _ref;

  NoticeBoardDataSourceImplementation(this._ref);

  late final ApiClient _apiClient = _ref.read(apiClientProvider);

  @override
  Future<List<Announcement>> getAnnouncements(String estateId) async {
    final response = await _apiClient
        .get(kAnnouncementRoute, queryParameters: {"estateId": estateId});
    return (response.data["data"]["list"] as List<dynamic>)
        .map((e) => Announcement.fromJson(e))
        .toList();
  }
}
