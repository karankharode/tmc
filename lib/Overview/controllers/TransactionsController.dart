import 'package:dio/dio.dart';
import 'package:tmc/Overview/models/transaction.dart';
import 'package:tmc/constants/config.dart';

class ItemListController {
  final dio = Dio();

  Future<ItemListResponse?> getItems() async {
    String endPointUrl = "https://atx-tmc.herokuapp.com/main/allTransactions";
    try {
      ItemListResponse? serverMsg = await _httpPostRequest(endPointUrl);
      return serverMsg;
    } catch (e) {
      print("caught");
      return null;
    }
  }

  Future<ItemListResponse?> _httpPostRequest(
    String url,
  ) async {
    ItemListResponse? itemListResponse;

    try {
      Response response;

      dio.options.baseUrl = url;
      dio.options.connectTimeout = 5000; //5s
      dio.options.receiveTimeout = 3000;
      dio.options.headers['auth'] = token.toString();
      dio.options.headers['accept'] = 'application/json';
      response = await dio.get(url);

      if (response.statusCode == 200) {
        itemListResponse = ItemListResponse.getItemListResponseFromHttpResponse(response);
        return itemListResponse;
      }
      return ItemListResponse(itemList: []);
    } on DioError catch (exception) {
      return exception.response?.data ?? ItemListResponse(itemList: []);
    }
  }
}
