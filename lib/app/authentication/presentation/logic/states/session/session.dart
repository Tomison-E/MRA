import 'package:mra/app/authentication/data/models/user.dart';
import 'package:mra/app/authentication/presentation/logic/listeners/on_before_logout.dart';
import 'package:mra/app/authentication/presentation/logic/listeners/on_login.dart';
import 'package:mra/app/authentication/presentation/logic/listeners/on_logout.dart';
import 'package:mra/core/services/storage/store.dart';
import 'package:flutter/cupertino.dart';

class Session extends ChangeNotifier
    implements OnLogout, OnBeforeLogout, OnLogin {
  String? accessToken;
  Session() : super() {
    setToken(Store.fetchTokenInfo());
  }

  void setToken(String? token) {
    if (token != null && accessToken != token) {
      accessToken = token;
      Store.saveTokenInfo(token);
    }
  }

  @override
  Future<void> onLogout() async {
    accessToken = null;
    Store.removeToken();
    notifyListeners();
  }

  @override
  Future<void> onBeforeLogout() async {}

  @override
  Future<void> onLogin(User user, [silent = false]) async {
    if(!silent) {
      notifyListeners();
    }
  }
}
