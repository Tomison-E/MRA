import 'package:mra/app/authentication/data/data_source/auth_source.dart';
import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/app/authentication/domain/params/login_params.dart';
import 'package:mra/app/authentication/domain/params/set_password_params.dart';
import 'package:mra/core/DI/di_providers.dart';
import 'package:mra/core/services/api/api_client.dart';
import 'package:mra/src/res/values/constants/api_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class AuthenticationDataSourceImplementation extends AuthenticationDataSource {
  final Ref _ref;
  AuthenticationDataSourceImplementation(this._ref);

  late final ApiClient _apiClient = _ref.read(apiClientProvider);

  @override
  Future<bool> getOTP(String phoneNumber) async {
    await _apiClient.post(
      kSendOtpApi,
      data: {"phoneNumber": phoneNumber},
    );
    return true;
  }

  @override
  Future<String> validateOTP(String phoneNumber, String otp) async {
    final response = await _apiClient.post(
      kVerifyOtpApi,
      data: {"phoneNumber": phoneNumber, "code": otp},
    );
    return response.data["data"]["authToken"];
  }

  @override
  Future<User> fetchUserDetails() async {
    final response = await _apiClient.get(kGetLoggedInUserApi);
    return User.fromJson(response.data["data"]);
  }

  @override
  Future<bool> setPassword(SetPasswordParams params) async {
    await _apiClient.put(kSetPasswordApi, data: params.toJson());
    return true;
  }

  @override
  Future<User> login(LoginParams params) async {
    final response = await _apiClient.post(kLoginApi, data: params.toJson());
    return User.fromJson(response.data["data"]["user"]);
  }

  @override
  Future<bool> acceptTerms() async {
    await _apiClient.put(kTermsApi);
    return true;
  }

  @override
  Future<String> fetchEstateRules(String estateId) async {
    final response = await _apiClient.get("$kEstateRoute/$estateId");
    return response.data["data"]?["rules"] ?? "";
  }

  @override
  Future<bool> uploadImage(XFile file) async {
    FormData formData = FormData.fromMap({
      'profile': MultipartFile.fromBytes(
        await file.readAsBytes(),
        contentType: MediaType.parse("image/png"),
        filename: file.name,
      ),
    });
    await _apiClient.post(kUploadApi, data: formData);
    return true;
  }
}
