import 'package:dio/dio.dart';
import 'package:tmc/Notifications/modals/TransactionById.dart';
import 'package:tmc/constants/config.dart';

class UpdateController {
  final dio = Dio();

  Future<ItemResponse?> getItemById(String id) async {
    String endPointUrl = 'https://atx-tmc.herokuapp.com/main/transaction/$id';
    try {
      ItemResponse? serverMsg = await _httpPostRequest(endPointUrl);
      return serverMsg;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> updateItem(String id, String status) async {
    String endPointUrl = 'https://atx-tmc.herokuapp.com/main/updateTransaction';
    try {
      bool serverMsg = await _httpPostRequestForUpdate(endPointUrl, id, status);
      return serverMsg;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<ItemResponse?> _httpPostRequest(
    String url,
  ) async {
    ItemResponse? itemResponse;

    try {
      Response response;

      dio.options.baseUrl = url;
      dio.options.headers['auth'] = token.toString();
      dio.options.headers['accept'] = 'application/json';
      response = await dio.get(url);

      if (response.statusCode == 200) {
        itemResponse = ItemResponse.getItemResponseFromHttpResponse(response);
        return itemResponse;
      }
    } on DioError catch (exception) {
      print(exception.error.toString());
      return exception.response?.data;
    }
  }

  Future<bool> _httpPostRequestForUpdate(
    String url,
    String id,
    String status,
  ) async {
    bool itemResponse;

    try {
      Response response;

      dio.options.baseUrl = url;
      dio.options.headers['auth'] = token.toString();
      dio.options.headers['accept'] = 'application/json';
      dio.options.headers['Content-Type'] = 'application/json';
      response = await dio.patch(url, data: {"id": id, "status": status});

      if (response.statusCode == 200) {
        itemResponse = response.data;
        return itemResponse;
      }
      return false;
    } on DioError catch (exception) {
      print(exception.error.toString());
      return exception.response?.data;
    }
  }
}