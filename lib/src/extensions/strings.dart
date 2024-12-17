import 'package:mra/app/authentication/data/models/locale.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

extension Strings on String {
  String get capitalize {
    String lowercase = toLowerCase();
    if (lowercase.length == 1) lowercase.toUpperCase();
    return lowercase[0].toUpperCase() + lowercase.substring(1);
  }

  String get removeSpaces {
    return replaceAll(" ", "");
  }

  Future<String?> getInternationalPhoneNumber(UserLocale locale) async {
    String phone = removeSpaces;
    try {
      final number = await parse(phone,region: locale.countryCode);
      return (number["international"] as String).removeSpaces;
    } catch (e) {
      return null;
    }
  }
}
