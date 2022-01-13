import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:tmc/LoginAndSignUp/modals/LoginData.dart';
import 'package:tmc/LoginAndSignUp/modals/LoginResponse.dart';
import 'package:tmc/LoginAndSignUp/modals/SignupuData.dart';
import 'package:tmc/common/SharedPreferencesUtil.dart';

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

  Future<String> signup(SignupData signupData) async {
    const endPointUrl = "";
    // final parameters = signupData.getFormData(signupData);

    // bool serverMsg = await _httpRequestForSignUp(endPointUrl, parameters);
    return 'User Created';
    // return serverMsg;
  }

  Future<LoginResponse?> getUserDetails(LoginData loginData) async {
    const endPointUrl = "";
    final parameters = loginData.getFormData(loginData);

    LoginResponse? serverMsg = await _httpRequestForUserDetails(
        endPointUrl, parameters, loginData.email, loginData.password);
    return serverMsg;
  }

  Future<LoginResponse?> login(LoginData loginData) async {
    const endPointUrl = "http://localhost:8080/auth/login";
    final parameters = loginData.getFormData(loginData);
    try {
      LoginResponse? serverMsg = await _httpPostRequest(
        endPointUrl,
        parameters,
        loginData.email,
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
      String url, FormData formData, String email, String password) async {
    LoginResponse? loginResponse;
    bool isAuthorized = false;

    try {
      print('Got here1');
      dio.options.headers['Content-Type'] = 'application/json';
      dio.options.headers['accept'] = 'application/json';

      var response = await  dio.post(url, data: formData);
      print('Got here2');
      print(response.statusCode);
      print(response.data['_id']);

      if (response.data['_id'] != null) {
        print('Got here3');
        response.data['Email'] = email;
        response.data['Password'] = password;
        loginResponse = LoginResponse.getLoginResponseFromHttpResponse(response, email, password);
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
      throw new Exception('Error');
    }
  }

  Future<bool> _httpRequestForSignUp(String url, FormData formData) async {
    try {
      bool result = false;
      var response = await dio.post(url, data: formData);
      if (response.data['registerStatus'] == true) {
        result = true;
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
