import 'package:dio/dio.dart';

class LoginData {
  final String username;
  final String password;

  const LoginData({required this.username, required this.password});

  FormData getFormData(LoginData loginData) {
    return FormData.fromMap({
      'username': loginData.username,
      'password': loginData.password,
    });
  }
}
