import 'package:mra/app/access_control/data/models/guest.dart';
import 'package:mra/app/access_control/domain/params/guest_history_params.dart';
import 'package:mra/app/access_control/domain/params/guest_params.dart';
import 'package:mra/app/access_control/domain/params/guest_update_params.dart';
import 'package:mra/app/access_control/domain/params/resident_verification_params.dart';
import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/core/service_result/service_result.dart';

abstract class AccessControlRepo {
  Future<ApiResult<bool>> inviteGuest(GuestParams guest);
  Future<ApiResult<bool>> updateGuest(GuestUpdateParams params);
  Future<ApiResult<List<Guest>>> fetchGuestHistory(GuestHistoryParams params);
  Future<ApiResult<List<User>>> verifyResident(
      ResidentVerificationParams params);
  Future<ApiResult<Guest>> fetchGuest(String code);
}
