import 'package:flutter/material.dart';

import '../object/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  User get getUser => _user!;

  Future<void> setUser(
    uid,
    username,
    email,
  ) async {
    _user = User(username: username, uid: uid, email: email);
    notifyListeners();
  }
}
