import 'package:mra/app/authentication/data/models/locale.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
import 'package:mra/src/extensions/strings.dart';

class Validators {
  static Future<String?> validatePhoneNumber(String? phoneNumber) async {
    if (phoneNumber == null) {
      return "Invalid Phone Number";
    }
    try {
      await parse(phoneNumber);
    } catch (e) {
      return "Phone Number Not Recognized";
    }
    return null;
  }

  static String? validatePassword(String? password) {
    RegExp numeric = RegExp(r'^-?\d+$');
    if (password?.isEmpty ?? true) {
      return 'Please provide your password';
    }
    if (password!.length < 8) {
      return 'Password must be at least 8 characters';
    }
    if (numeric.hasMatch(password)) {
      return 'Password must contain alphabets';
    }
    return null;
  }

  static String? Function(String?) validateDiffChange(
    String field, [
    String? error,
  ]) {
    return (String? value) {
      if (field != value) {
        return error ?? 'Values don\'t match';
      }
      return null;
    };
  }

  static String? confirmPassword(String? value, String passwordField) {
    if (value!.isEmpty) {
      return 'Please enter a password.';
    }
    return validateDiffChange(
      passwordField,
      'The passwords don\'t match',
    )(value);
  }

  static String? verifyPassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  static String? verifyInput(String? value) {
    if (value!.isEmpty) {
      return 'Field is required';
    }
    return null;
  }
}
