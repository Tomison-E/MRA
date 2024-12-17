import 'package:mra/app/access_control/data/models/guest.dart';
import 'package:mra/app/access_control/domain/params/guest_history_params.dart';
import 'package:mra/app/access_control/domain/params/guest_params.dart';
import 'package:mra/app/access_control/domain/params/guest_update_params.dart';
import 'package:mra/app/access_control/domain/params/resident_verification_params.dart';
import 'package:mra/app/authentication/data/models/user.dart';

abstract class AccessControlDataSource {
  Future<bool> inviteGuest(GuestParams guest);
  Future<bool> updateGuest(GuestUpdateParams params);
  Future<Guest> fetchGuest(String code);
  Future<List<Guest>> fetchGuestHistory(GuestHistoryParams params);
  Future<List<User>> verifyResident(ResidentVerificationParams params);
}
