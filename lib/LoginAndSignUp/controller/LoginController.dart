import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tmc/LoginAndSignUp/modals/LoginData.dart';
import 'package:tmc/LoginAndSignUp/modals/LoginResponse.dart';
import 'package:tmc/LoginAndSignUp/modals/SignupuData.dart';
import 'package:tmc/common/SharedPreferencesUtil.dart';
import 'package:http/http.dart' as http;

class LoginController {
  static final _sharedPref = SharedPref.instance;
  final dio = Dio();

  Future<bool> isUserAuthorized() async {
    return await SharedPref.instance.readIsLoggedIn();
  }

  Future<LoginResponse> getSavedUserDetails() async {
    String? data = await _sharedPref.getUser();
    LoginResponse loginResponse = new LoginResponse.fromJson(json.decode(data.toString()));
    return loginResponse;
  }

  Future<String> signup(String username, String password) async {
    const endPointUrl = 'https://atx-tmc.herokuapp.com/auth/register';

    String serverMsg = await _httpRequestForSignUp(endPointUrl,  username,  password);
    return serverMsg;
    // return serverMsg;
  }

  Future<LoginResponse?> getUserDetails(LoginData loginData) async {
    const endPointUrl = "";
    final parameters = loginData.getFormData(loginData);

    LoginResponse? serverMsg = await _httpRequestForUserDetails(
        endPointUrl, parameters, loginData.username, loginData.password);
    return serverMsg;
  }

  Future<LoginResponse?> login(LoginData loginData) async {
    const endPointUrl = "https://atx-tmc.herokuapp.com/auth/login";
    final parameters = loginData.getFormData(loginData);
    try {
      LoginResponse? serverMsg = await _httpPostRequest(
        endPointUrl,
        parameters,
        loginData.username,
        loginData.password,
      );
      print(serverMsg.toString());
      return serverMsg;
    } catch (e) {
      print(e);
      print("caught");
      return null;
    }
  }

  Future<LoginResponse?> _httpRequestForUserDetails(
    String url,
    FormData formData,
    String email,
    String password,
  ) async {
    LoginResponse? loginResponse;
    bool isAuthorized = false;
    try {
      var response = await dio.post(url, data: formData);

      if (response.data['status'] == true && response.data['id'] != null) {
        response.data['Email'] = email;
        response.data['Password'] = password;
        response.data['password'] = password;
        loginResponse = LoginResponse.getUserDetailsLoginResponseFromHttpResponse(response);

        isAuthorized = true;
      }

      if (isAuthorized) {
        return loginResponse;
      } else {
        return null;
      }
    } catch (e) {
      throw new Exception('Error');
    }
  }

  Future<LoginResponse?> _httpPostRequest(
      String url, FormData formData, String username, String password) async {
    LoginResponse? loginResponse;
    bool isAuthorized = false;

    try {
// Set default configs
      dio.options.baseUrl = 'https://atx-tmc.herokuapp.com/auth/login';
      dio.options.connectTimeout = 5000; //5s
      dio.options.receiveTimeout = 3000;

// or new Dio with a BaseOptions instance.
      var options = BaseOptions(
        baseUrl: 'https://atx-tmc.herokuapp.com/auth/login',
        connectTimeout: 5000,
        receiveTimeout: 3000,
      );
      // Dio dio = Dio(options);

      //
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers["Access-Control-Allow-Origin"] = "*";
      dio.options.headers['accept'] = 'application/json';

      var response = await dio.post(
        url,
        data: {"username": username, "password": password},
      );
      print('Got here2');
      print(response.statusCode);
      print(response.data);
      // print(response.data['_id']);

      if (response.statusCode == 200) {
        print('Got here3');
        loginResponse = LoginResponse.getLoginResponseFromHttpResponse(response);
        print(loginResponse);
        print('Got here4');
        // _sharedPref.saveIsLoggedIn(true);
        // _sharedPref.saveUser(json.encode(response.data));
        isAuthorized = true;
      }
      if (isAuthorized) {
        return loginResponse;
      } else {
        return null;
      }
    } catch (e) {
      print(e);

      throw new Exception('Error');
    }
  }

  Future<String> _httpRequestForSignUp(
      String url, String username, String password ) async {
    try {
      String result = "Error";
      var response = await dio.post(url, data: {
        'username': username,
        'password': password,
      });
      if (response.data['status'] == "Successful registration") {
        result = "Successful registration";
      }else if (response.data['status'] == "Username already Exists !") {
        result = "Username already Exists !";
      }
      return result;
    } catch (e) {
      throw Exception('Error');
    }
  }

  Future<bool> logOut() {
    _sharedPref.removeUser();
    return _sharedPref.removeIsLoggedIn();
  }
}
