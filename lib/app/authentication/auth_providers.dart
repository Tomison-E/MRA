import 'package:mra/app/authentication/data/data_source/auth_source.dart';
import 'package:mra/app/authentication/data/data_source/auth_source_impl.dart';
import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/app/authentication/data/repo_impl/auth_repo_impl.dart';
import 'package:mra/app/authentication/domain/params/login_params.dart';
import 'package:mra/app/authentication/domain/repo/auth_repo.dart';
import 'package:mra/app/authentication/presentation/logic/states/session/session.dart';
import 'package:mra/app/authentication/presentation/logic/states/user_state/user_state.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/service_result/service_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authDataProvider = Provider<AuthenticationDataSource>((ref) {
  return AuthenticationDataSourceImplementation(ref);
});

final authRepoProvider = Provider<AuthRepo>((ref) {
  return AuthRepoImplementation(ref);
});

final userStateProvider = NotifierProvider<UserState, User?>(() {
  return UserState();
});

final loginUseCaseProvider =
    AutoDisposeProviderFamily<Future<ApiResult<User>>, LoginParams>(
  (ref, arg) => UseCase<User>().call(
    () => ref.read(authRepoProvider).login(arg),
  ),
);

final fetchRulesUseCaseProvider =
    AutoDisposeProvider<Future<ApiResult<String>>>(
  (ref) => UseCase<String>().call(
    () => ref
        .read(authRepoProvider)
        .fetchEstateRules(ref.read(userStateProvider)!.houseHold.householdId),
  ),
);

/*final setPasswordProvider =
    AutoDisposeFutureProviderFamily<bool, SetPasswordParams>((ref, arg) async{
  final userNotifier = ref.watch(userStateProvider.notifier);
  return userNotifier.setUserPassword(arg);
});*/

final sessionProvider = StateProvider((ref) => Session());
