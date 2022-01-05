import 'package:dio/dio.dart';

class SignupData {
  final String password;
  final String username;

  const SignupData({required this.password, required this.username});

  FormData getFormData(SignupData signupData) {
    return FormData.fromMap({
      'password': signupData.password,
      'username': signupData.username,
    });
  }
}
