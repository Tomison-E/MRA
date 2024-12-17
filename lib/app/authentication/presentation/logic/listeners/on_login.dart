import 'package:mra/app/authentication/data/models/user.dart';

abstract class OnLogin {
  Future<void> onLogin(User user,[bool silent = false]);
}
