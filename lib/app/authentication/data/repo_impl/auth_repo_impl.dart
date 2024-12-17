import 'package:mra/app/authentication/auth_providers.dart';
import 'package:mra/app/authentication/data/data_source/auth_source.dart';
import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/app/authentication/domain/params/login_params.dart';
import 'package:mra/app/authentication/domain/params/set_password_params.dart';
import 'package:mra/app/authentication/domain/repo/auth_repo.dart';
import 'package:mra/core/helpers/dio_interceptor.dart';
import 'package:mra/core/service_result/src/api_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AuthRepoImplementation extends AuthRepo {
  final Ref _ref;
  AuthRepoImplementation(this._ref);

  late final AuthenticationDataSource _dataSource = _ref.read(authDataProvider);

  @override
  Future<ApiResult<bool>> requestOTP(String phoneNumber) {
    return dioInterceptor(() => _dataSource.getOTP(phoneNumber));
  }

  @override
  Future<ApiResult<String>> verifyOTP(String phoneNumber, String otp) {
    return dioInterceptor(() => _dataSource.validateOTP(phoneNumber, otp));
  }

  @override
  Future<ApiResult<bool>> setPassword(SetPasswordParams params) {
    return dioInterceptor(() => _dataSource.setPassword(params));
  }

  @override
  Future<ApiResult<User>> fetchUserDetails() {
    return dioInterceptor(() => _dataSource.fetchUserDetails());
  }

  @override
  Future<ApiResult<User>> login(LoginParams params) {
    return dioInterceptor(() => _dataSource.login(params));
  }

  @override
  Future<ApiResult<bool>> acceptTerms() {
    return dioInterceptor(() => _dataSource.acceptTerms());
  }

  @override
  Future<ApiResult<String>> fetchEstateRules(String estateId) {
    return dioInterceptor(() => _dataSource.fetchEstateRules(estateId));
  }

  @override
  Future<ApiResult<bool>> uploadImage(XFile file) {
    return dioInterceptor(() => _dataSource.uploadImage(file));
  }
}
