import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tmc/LoginAndSignUp/modals/LoginData.dart';
import 'package:tmc/LoginAndSignUp/modals/LoginResponse.dart';
import 'package:tmc/common/SharedPreferencesUtil.dart';

class LoginController {
  final dio = Dio();
  static final _sharedPref = SharedPref.instance;

  Future<bool> isUserAuthorized() async {
    // return false;
    return await SharedPref.instance.readIsLoggedIn();
  }

  Future<LoginResponse> getSavedUserDetails() async {
    String? data = await _sharedPref.getUser();
    // print("Data from prefs : " + data!);
    LoginResponse loginResponse = new LoginResponse.fromJson(json.decode(data!));
    return loginResponse;
  }

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

      print("Request Status Code : ${response.statusCode}\n");
      print("Request Data : ${response.data}\n");

      if (response.statusCode == 200) {
        loginResponse = LoginResponse.getLoginResponseFromHttpResponse(response);
        _sharedPref.saveIsLoggedIn(true);
        _sharedPref.saveUser(json.encode(response.data));
      }

      return loginResponse;
    } on DioError catch (exception) {
      print(exception.error.toString()+"\n");
      if (exception.error.toString() == "XMLHttpRequest error.") {
        return LoginResponse(
            token: "no internet", responseText: "Sorry we could not log you in. Please try again.");
      }

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
      print(result+"\n");
      print("Request Status Code : ${response.statusCode}}\n");

      return result;
    } on DioError catch (exception) {
      print(exception.error.toString()+"\n");
      // print(exception.message.toString());
      return exception.response?.data ?? "Error in getting data from server\n";
    }
  }

  Future<bool> logOut() {
    print("Logging Out...\n");
    _sharedPref.removeUser();
    return _sharedPref.removeIsLoggedIn();
  }
}
