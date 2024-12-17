import 'package:mra/app/access_control/data/models/guest.dart';
import 'package:mra/app/access_control/data/repo_impl/access_control_repo_impl.dart';
import 'package:mra/app/access_control/domain/params/guest_history_params.dart';
import 'package:mra/app/access_control/domain/params/guest_params.dart';
import 'package:mra/app/access_control/domain/params/guest_update_params.dart';
import 'package:mra/app/access_control/domain/params/resident_verification_params.dart';
import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/service_result/service_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final inviteGuestUseCaseProvider =
    AutoDisposeProviderFamily<Future<ApiResult<bool>>, GuestParams>(
  (ref, arg) => UseCase<bool>().call(
    () => ref.read(accessControlRepoProvider).inviteGuest(arg),
  ),
);

final updateGuestUseCaseProvider =
    AutoDisposeProviderFamily<Future<ApiResult<bool>>, GuestUpdateParams>(
  (ref, arg) => UseCase<bool>().call(
    () => ref.read(accessControlRepoProvider).updateGuest(arg),
  ),
);

final fetchGuestHistoryUseCaseProvider = AutoDisposeProviderFamily<
    Future<ApiResult<List<Guest>>>, GuestHistoryParams>(
  (ref, arg) => UseCase<List<Guest>>().call(
    () => ref.read(accessControlRepoProvider).fetchGuestHistory(arg),
  ),
);

final residentVerificationUseCaseProvider = AutoDisposeProviderFamily<
    Future<ApiResult<List<User>>>, ResidentVerificationParams>(
  (ref, arg) => UseCase<List<User>>().call(
    () => ref.read(accessControlRepoProvider).verifyResident(arg),
  ),
);

final guestVerificationUseCaseProvider =
    AutoDisposeProviderFamily<Future<ApiResult<Guest>>, String>(
  (ref, arg) => UseCase<Guest>().call(
    () => ref.read(accessControlRepoProvider).fetchGuest(arg),
  ),
);
