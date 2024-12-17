import 'package:mra/app/authentication/data/models/user.dart';

abstract class OnUserChanged {
  Future<void> onUserChanged(User? before, User after);
}
