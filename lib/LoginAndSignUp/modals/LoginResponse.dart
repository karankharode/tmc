import 'package:dio/dio.dart';

class LoginResponse {
  final String token;

  LoginResponse({
    required this.token,
  });

  factory LoginResponse.getLoginResponseFromHttpResponse(
      Response<dynamic> response) {
    print('Got here 5');
    print(response);
    return LoginResponse(
        token: response.data['auth'],
       );
  }

  factory LoginResponse.getUserDetailsLoginResponseFromHttpResponse(Response<dynamic> response) {
    return LoginResponse(
      token: response.data['auth'],
    );
  }

  factory LoginResponse.fromJson(Map<String, dynamic> parsedJson) {
    return new LoginResponse(
      token: parsedJson['token'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return {
      data["token"]: this.token,
    };
  }
}
