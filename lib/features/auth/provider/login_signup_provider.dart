import 'package:flutter/material.dart';

enum AuthType { login, signup }

class LoginSignupProvider extends ChangeNotifier {
  AuthType _authType = AuthType.signup;

  AuthType get authType => _authType;

  set authTypeFun(AuthType value) {
    _authType = value;
    notifyListeners();
  }
}
