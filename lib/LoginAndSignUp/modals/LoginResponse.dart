import 'package:dio/dio.dart';

class LoginResponse {
  final String token;
  String responseText = "Successful";

  LoginResponse({required this.token, this.responseText = "Successful"});

  factory LoginResponse.getLoginResponseFromHttpResponse(Response<dynamic> response) {
    return LoginResponse(
      token: response.data['auth'],
      // responseText: response.data['auth'],
    );
  }
}
