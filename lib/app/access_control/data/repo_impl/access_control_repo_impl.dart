import 'package:mra/app/access_control/data/data_source/access_control_source.dart';
import 'package:mra/app/access_control/data/data_source/access_control_source_impl.dart';
import 'package:mra/app/access_control/data/models/guest.dart';
import 'package:mra/app/access_control/domain/params/guest_history_params.dart';
import 'package:mra/app/access_control/domain/params/guest_params.dart';
import 'package:mra/app/access_control/domain/params/guest_update_params.dart';
import 'package:mra/app/access_control/domain/params/resident_verification_params.dart';
import 'package:mra/app/access_control/domain/repo/access_control_repo.dart';
import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/core/helpers/dio_interceptor.dart';
import 'package:mra/core/service_result/src/api_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccessControlRepoImplementation extends AccessControlRepo {
  final Ref _ref;

  AccessControlRepoImplementation(this._ref);

  late final AccessControlDataSource _dataSource =
      _ref.read(accessControlDataProvider);

  @override
  Future<ApiResult<List<Guest>>> fetchGuestHistory(GuestHistoryParams params) =>
      dioInterceptor(() => _dataSource.fetchGuestHistory(params));

  @override
  Future<ApiResult<bool>> inviteGuest(GuestParams guest) =>
      dioInterceptor(() => _dataSource.inviteGuest(guest));

  @override
  Future<ApiResult<bool>> updateGuest(GuestUpdateParams params) =>
      dioInterceptor(() => _dataSource.updateGuest(params));

  @override
  Future<ApiResult<List<User>>> verifyResident(
      ResidentVerificationParams params) {
    return dioInterceptor(() => _dataSource.verifyResident(params));
  }

  @override
  Future<ApiResult<Guest>> fetchGuest(String code) {
    return dioInterceptor(() => _dataSource.fetchGuest(code));
  }
}

final accessControlRepoProvider = Provider<AccessControlRepo>((ref) {
  return AccessControlRepoImplementation(ref);
});
