import 'package:dio/dio.dart';

class LoginResponse {
  final String token;
  // final String responseText;

  LoginResponse({
    required this.token,
    // required this.responseText,
  });

  factory LoginResponse.getLoginResponseFromHttpResponse(Response<dynamic> response) {
    return LoginResponse(
      token: response.data['auth'],
      // responseText: response.data['auth'],
    );
  }
}
