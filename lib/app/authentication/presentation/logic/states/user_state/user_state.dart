import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/app/authentication/domain/params/login_params.dart';
import 'package:mra/app/authentication/domain/params/set_password_params.dart';
import 'package:mra/app/authentication/presentation/logic/listeners/on_before_logout.dart';
import 'package:mra/app/authentication/presentation/logic/listeners/on_login.dart';
import 'package:mra/app/authentication/presentation/logic/listeners/on_logout.dart';
import 'package:mra/core/service_result/src/api_result.dart';
import 'package:mra/core/services/storage/store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class UserState extends Notifier<User?>
    implements OnLogin, OnLogout, OnBeforeLogout {
  UserState();

  late final _authRepo = ref.read(authRepoProvider);
  late final _session = ref.read(sessionProvider);

  void _setUser(User currentUser) {
    state = currentUser;
    Store.saveUserInfo(currentUser);
  }

  void _removeUser() {
    state = null;
    Store.removeUser();
  }

  Future<ApiResult<bool>> setUserPassword(SetPasswordParams params) async {
    final response = await _authRepo.setPassword(params);
    return response.when(
        success: (_) {
          return fetchUserDetails();
        },
        apiFailure: (fail, _) => ApiResult.apiFailure(error: fail));
  }

  Future<ApiResult<String>> verifyOtp(String phoneNumber, String otp) async {
    final response = await _authRepo.verifyOTP(phoneNumber, otp);
    response.maybeWhen(
        success: (token) {
          _session.setToken(token);

        },
        orElse: () {});
    return response;
  }

  Future<ApiResult<bool>> acceptTerms() async {
    final response = await _authRepo.acceptTerms();
    response.maybeWhen(
        success: (token) {
          fetchUserDetails();
        },
        orElse: () {});
    return response;
  }

  Future<ApiResult<bool>> uploadImg(XFile file) async {
    final response = await _authRepo.uploadImage(file);
    response.maybeWhen(
        success: (token) {
          fetchUserDetails();
        },
        orElse: () {});
    return response;
  }

  Future<ApiResult<bool>> login(LoginParams params) async {
    final response = await _authRepo.login(params);
    return response.when(
        success: (user) {
          _session.setToken(params.authToken);
          onLogin(user);
          return const ApiResult.success(data: true);
        },
        apiFailure: (fail, _) => ApiResult.apiFailure(error: fail));
  }

  Future<ApiResult<bool>> fetchUserDetails() async {
    final response = await _authRepo.fetchUserDetails();
    return response.when(
        success: (user) {
          onLogin(user);
          return const ApiResult.success(data: true);
        },
        apiFailure: (fail, _) => ApiResult.apiFailure(error: fail));
  }

  final _stateListeners = [sessionProvider];

  @override
  Future<void> onLogin(User user, [silent = false]) async {
    _setUser(user);
    _sendUserLoginEvent(user, silent);
  }

  Future<void> _sendUserLoginEvent(User user, [silent = false]) async {
    for (var element in _stateListeners) {
      final stateObject = ref.read(element);
      if (stateObject is OnLogin) stateObject.onLogin(user, silent);
    }
    await Future.value();
  }

  Future<void> _sendUserLogoutEvent() async {
    for (var element in _stateListeners) {
      final stateObject = ref.read(element);
      if (stateObject is OnLogout) stateObject.onLogout();
    }
    await Future.value();
  }

  Future<void> _sendUserOnBeforeLogoutEvent() async {
    for (var element in _stateListeners) {
      final stateObject = ref.read(element);
      if (stateObject is OnBeforeLogout) stateObject.onBeforeLogout();
    }
    await Future.value();
  }

  @override
  Future<void> onLogout() async {
    _removeUser();
    _sendUserLogoutEvent();
  }

  @override
  User? build() {
    final user = Store.fetchUserInfo();
    if (user != null) {
      onLogin(user, true);
    }
    return user;
  }

  @override
  Future<void> onBeforeLogout() async {
    _sendUserOnBeforeLogoutEvent();
  }
}
