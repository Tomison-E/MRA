import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/app/authentication/domain/params/login_params.dart';
import 'package:mra/app/authentication/domain/params/set_password_params.dart';
import 'package:mra/core/service_result/service_result.dart';
import 'package:image_picker/image_picker.dart';

abstract class AuthRepo {
  Future<ApiResult<bool>> requestOTP(String phoneNumber);
  Future<ApiResult<String>> verifyOTP(
      String phoneNumber, String otp);
  Future<ApiResult<bool>> setPassword(SetPasswordParams params);
  Future<ApiResult<User>> fetchUserDetails();
  Future<ApiResult<User>> login(LoginParams params);
  Future<ApiResult<String>> fetchEstateRules(String estateId);
  Future<ApiResult<bool>> acceptTerms();
  Future<ApiResult<bool>> uploadImage(XFile file);
}
