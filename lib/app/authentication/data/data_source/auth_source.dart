import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/app/authentication/domain/params/login_params.dart';
import 'package:mra/app/authentication/domain/params/set_password_params.dart';
import 'package:image_picker/image_picker.dart';

abstract class AuthenticationDataSource {
  Future<bool> getOTP(String phoneNumber);
  Future<String> validateOTP(String phoneNumber, String otp);
  Future<bool> setPassword(SetPasswordParams params);
  Future<User> fetchUserDetails();
  Future<User> login(LoginParams params);
  Future<String> fetchEstateRules(String estateId);
  Future<bool> acceptTerms();
  Future<bool> uploadImage(XFile file);
}
