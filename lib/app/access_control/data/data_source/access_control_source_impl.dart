import 'package:mra/app/access_control/data/data_source/access_control_source.dart';
import 'package:mra/app/access_control/data/models/guest.dart';
import 'package:mra/app/access_control/domain/params/guest_history_params.dart';
import 'package:mra/app/access_control/domain/params/guest_params.dart';
import 'package:mra/app/access_control/domain/params/guest_update_params.dart';
import 'package:mra/app/access_control/domain/params/resident_verification_params.dart';
import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/services/api/api_client.dart';
import 'package:mra/src/res/values/constants/api_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccessControlDataSourceImplementation extends AccessControlDataSource {
  final Ref _ref;

  AccessControlDataSourceImplementation(this._ref);

  late final ApiClient _apiClient = _ref.read(apiClientProvider);

  @override
  Future<List<Guest>> fetchGuestHistory(GuestHistoryParams params) async {
    final response = await _apiClient.get(kGuestHistoryRoute,
        queryParameters: params.toJson());
    return (response.data["data"]["list"] as List<dynamic>)
        .map((e) => Guest.fromJson(e))
        .toList();
  }

  @override
  Future<bool> inviteGuest(GuestParams guest) async {
    await _apiClient.post(kGuestRoute, data: guest.toInviteGuestJson());
    return true;
  }

  @override
  Future<bool> updateGuest(GuestUpdateParams params) async {
    await _apiClient.put(kGuestUpdateRoute, data: params.toJson());
    return true;
  }

  @override
  Future<List<User>> verifyResident(ResidentVerificationParams params) async {
    final response =
        await _apiClient.get(kUserRoute, queryParameters: params.toMap());
    return (response.data["data"]["list"] as List)
        .map((e) => User.fromJson(e))
        .toList();
  }

  @override
  Future<Guest> fetchGuest(String code) async {
    final response = await _apiClient
        .get(kGuestRoute, queryParameters: {"accessCode": code});
    return Guest.fromJson(response.data["data"]);
  }
}

final accessControlDataProvider = Provider<AccessControlDataSource>((ref) {
  return AccessControlDataSourceImplementation(ref);
});
