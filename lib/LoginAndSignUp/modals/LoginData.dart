import 'package:dio/dio.dart';

class LoginData {
  final String email;
  final String password;

  const LoginData({required this.email, required this.password});

  FormData getFormData(LoginData loginData) {
    return FormData.fromMap({
      'email': loginData.email,
      'password': loginData.password,
    });
  }
}
