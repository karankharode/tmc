import 'package:dio/dio.dart';

class RefreshToken {
  final dio = Dio();

  Future<String> refreshToken(String token) async {
    const endPointUrl = 'https://atx-tmc.herokuapp.com/auth/refreshToken';

    String serverMsg = await _httpRequestForRefresh(
      endPointUrl,
      token,
    );
    return serverMsg;
  }

  Future<String> _httpRequestForRefresh(String url, String token) async {
    try {
      String result = "Error";
      dio.options.baseUrl = url;
      dio.options.connectTimeout = 5000; //5s
      dio.options.receiveTimeout = 3000;
      dio.options.headers['auth'] = token.toString();
      dio.options.headers['accept'] = 'application/json';

      var response = await dio.get(url);
      // print(response.data);

      if (response.data['status'] == "Refresh Token created") {
        result = response.data["auth"].toString();
        print("Token refreshed : ${response.data['auth']}");
      }

      return result;
    } on DioError catch (exception) {
      return exception.response?.data ?? "Error creating Refresh Token";
    }
  }
}
