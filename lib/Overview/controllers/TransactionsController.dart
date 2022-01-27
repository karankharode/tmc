import 'package:dio/dio.dart';
import 'package:tmc/Overview/models/transaction.dart';
import 'package:tmc/constants/config.dart';

class ItemListController {
  final dio = Dio();

  Future<ItemListResponse?> getItems(
    int page,
    int limit, {
    String keyword = '',
    String source_service = '',
    String start_date = 'null',
    String end_Date = 'null',
  }) async {
    String endPointUrl =
        "https://atx-tmc.herokuapp.com/main/allTransactions?page=$page&limit=$limit";
    String extension = "";
    if (keyword != "") extension = extension + "&keyword=$keyword";

    if (source_service != "") extension = extension + "&source_service=$source_service";

    endPointUrl = endPointUrl + extension;

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
    } on DioError catch (exception) {
      return exception.response?.data;
    }
  }
}
