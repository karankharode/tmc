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
    String start_date = '',
    String end_Date = '',
  }) async {
    String endPointUrl =
        "https://atx-tmc.herokuapp.com/main/allTransactions?page=$page&limit=$limit";
    String extension = "";
    if (keyword != "") extension = extension + "&keyword=$keyword";

    if (source_service != "") extension = extension + "&source_service=$source_service";
    if (start_date != "") extension = extension + "&start_date=$start_date";
    if (end_Date != "") extension = extension + "&end_date=$end_Date";

    endPointUrl = endPointUrl + extension;

    print("Getting data for endpoint - $endPointUrl \n");

    try {
      ItemListResponse? serverMsg = await _httpPostRequest(endPointUrl);
      return serverMsg;
    } catch (e) {
      print("Error occured!");
      return ItemListResponse(
          totalDocs: -3,
          limit: 0,
          totalPages: 0,
          page: 0,
          pageCounter: 0,
          hasPrevPage: false,
          hasNextPage: false,
          prevPage: 0,
          nextPage: 0,
          itemList: []);
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
      print("Request Status Code : ${response.statusCode}");

      if (response.statusCode == 200) {
        itemListResponse = ItemListResponse.getItemListResponseFromHttpResponse(response);
        return itemListResponse;
      }
    } on DioError catch (exception) {
      print(exception.error.toString());
      if (exception.error.toString() == "XMLHttpRequest error.") {
        return ItemListResponse(
            totalDocs: -1,
            limit: 0,
            totalPages: 0,
            page: 0,
            pageCounter: 0,
            hasPrevPage: false,
            hasNextPage: false,
            prevPage: 0,
            nextPage: 0,
            itemList: []);
      }
      return ItemListResponse(
          totalDocs: -2,
          limit: 0,
          totalPages: 0,
          page: 0,
          pageCounter: 0,
          hasPrevPage: false,
          hasNextPage: false,
          prevPage: 0,
          nextPage: 0,
          itemList: []);
    }
  }
}
