import 'package:mra/app/authentication/data/models/user.dart';

class UserLocale {
  final String countryCode;
  final String phoneCode;
  final int phoneInputLength;

  UserLocale(this.countryCode, this.phoneCode, this.phoneInputLength);

  static UserLocale getLocality(Country countryCode) {
    switch (countryCode) {
      case Country.ng:
        return const UserLocale.ng();
      case Country.gh:
        return UserLocale("GH", "233", 10);
    }
  }

  const UserLocale.ng()
      : phoneCode = '234',
        countryCode = 'NG',
        phoneInputLength = 11;
}
