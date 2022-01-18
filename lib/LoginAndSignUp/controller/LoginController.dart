import 'package:dio/dio.dart';
import 'package:tmc/LoginAndSignUp/modals/LoginData.dart';
import 'package:tmc/LoginAndSignUp/modals/LoginResponse.dart';
import 'package:tmc/constants/colors.dart';

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
      print(serverMsg.toString());
      return serverMsg;
    } catch (e) {
      print(e);
      print("error");
      return LoginResponse(token: 'null');
    }
  }

  Future<LoginResponse> _httpPostRequest(
      String url, FormData formData, String username, String password) async {
    LoginResponse loginResponse = LoginResponse(token: 'null');
    bool isAuthorized = false;

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
      print('Got here2');
      print(response.statusCode);
      print(response.data);
      // print(response.data['_id']);

      if (response.statusCode == 200) {
        print('Got here3');
        loginResponse = LoginResponse.getLoginResponseFromHttpResponse(response);
        isAuthorized = true;
      }
      return loginResponse;
    } catch (e) {
      print(e);

      throw new Exception('Error');
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
      try {
        if (response.data['status'] == "Successful registration") {
          result = "Successful registration";
        } else if (response.data['status'] == "Username already Exists !") {
          result = "Username already Exists !";
        }
      } catch (e) {
        print("error during parsing");
      }
      print(response.data);
      return result;
    } catch (e) {
      print('Error during api call');
      return 'Error';
    }
  }
}
