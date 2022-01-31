import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tmc/LoginAndSignUp/modals/LoginData.dart';
import 'package:tmc/LoginAndSignUp/modals/LoginResponse.dart';

class LoginController {
  final dio = Dio();

  Future<String> signup(String username, String password) async {
    const endPointUrl = 'https://atx-tmc.herokuapp.com/auth/register';

    String serverMsg = await _httpRequestForSignUp(endPointUrl, username, password);
    return serverMsg;
    // return serverMsg;
  }

  Future<LoginResponse> login(LoginData loginData) async {
    const endPointUrl = "https://atx-tmc.herokuapp.com/auth/login";
    final parameters = loginData.getFormData(loginData);
    try {
      LoginResponse serverMsg = await _httpPostRequest(
        endPointUrl,
        parameters,
        loginData.username,
        loginData.password,
      );
      return serverMsg;
    } catch (e) {
      // debugPrint(e.toString());
      return LoginResponse(token: 'null', responseText: "Error in getting data from server");
    }
  }

  Future<LoginResponse> _httpPostRequest(
      String url, FormData formData, String username, String password) async {
    LoginResponse loginResponse = LoginResponse(token: 'null');

    try {
// Set default configs
      dio.options.baseUrl = 'https://atx-tmc.herokuapp.com/auth/login';
      dio.options.connectTimeout = 5000; //5s
      dio.options.receiveTimeout = 3000;
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers["Access-Control-Allow-Origin"] = "*";
      dio.options.headers['accept'] = 'application/json';

      var response = await dio.post(
        url,
        data: {"username": username, "password": password},
      );

      if (response.statusCode == 200) {
        loginResponse = LoginResponse.getLoginResponseFromHttpResponse(response);
      }

      return loginResponse;
    } on DioError catch (exception) {
      return LoginResponse(
          token: "null",
          responseText: exception.response?.data ?? "Error in getting data from server");
    }
  }

  Future<String> _httpRequestForSignUp(String url, String username, String password) async {
    try {
      String result = "Error";
      dio.options.baseUrl = 'https://atx-tmc.herokuapp.com/auth/register';
      dio.options.connectTimeout = 5000; //5s
      dio.options.receiveTimeout = 3000;
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers["Access-Control-Allow-Origin"] = "*";
      dio.options.headers['accept'] = 'application/json';

      var response = await dio.post(url, data: {
        'username': username,
        'password': password,
      });

      if (response.data['status'] == "Successful registration") {
        result = "Successful registration";
      } else if (response.data['status'] == "Username already Exists !") {
        result = "Username already Exists !";
      }

      return result;
    } on DioError catch (exception) {
      return exception.response?.data ?? "Error in getting data from server";
    }
  }
}
