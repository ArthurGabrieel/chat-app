import 'dart:io';

enum AuthMode { signUp, login }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode _mode = AuthMode.login;

  bool get isLogin => _mode == AuthMode.login;

  void toggleMode() {
    _mode = isLogin ? AuthMode.signUp : AuthMode.login;
  }
}
