import 'package:contackflutter/models/user.dart';
import 'package:contackflutter/services/auth.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User? get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    print(user);
    _user = user;
    notifyListeners();
  }
}
