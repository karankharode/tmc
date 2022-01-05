import 'package:dio/dio.dart';

class LoginResponse {
  final String id;
  final String email;
  final String password;

  LoginResponse({
    required this.id,
    required this.email,
    required this.password,
  });

  factory LoginResponse.getLoginResponseFromHttpResponse(
      Response<dynamic> response, String email, String password) {
    print('Got here 5');
    print(response);
    print(email);
    print(password);
    return LoginResponse(
        id: response.data['_id']['oid'],
        email: response.data['username'],
        password: response.data['password']);
  }

  factory LoginResponse.getUserDetailsLoginResponseFromHttpResponse(Response<dynamic> response) {
    return LoginResponse(
      email: response.data['Email'],
      password: response.data['Password'],
      id: response.data['_id']['oid'],
    );
  }

  factory LoginResponse.fromJson(Map<String, dynamic> parsedJson) {
    return new LoginResponse(
      id: parsedJson['id'] ?? "",
      email: parsedJson['Email'] ?? "",
      password: parsedJson['Password'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    return {
      data["Email"]: this.email,
      data["Password"]: this.password,
      data["id"]: this.id,
    };
  }
}
