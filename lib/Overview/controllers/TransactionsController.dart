
import 'package:dio/dio.dart';
import 'package:tmc/Overview/models/transaction.dart';
import 'package:tmc/common/SharedPreferencesUtil.dart';

class ItemListController {
  static final _sharedPref = SharedPref.instance;
  final dio = Dio();

  Future<ItemListResponse?> getItems() async {
    // print("here 1");
    String endPointUrl =
        "https://my-json-server.typicode.com/karankharode/demo/transaction_success"; // print("here 2");
    try {
      ItemListResponse? serverMsg = await _httpPostRequest(endPointUrl);
      // print("here 3");
      print(serverMsg.toString());
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
    bool isAuthorized = false;
    try {
      // print("here 4");
      var response;
      try {
        response = await dio.get(url);
      } catch (e) {
        print(e);
        if (e.toString() == 'DioError [DioErrorType.RESPONSE]: Http status error [403]') {
          print('Error caught for 403');
          return null;
        }
      }
      // print("here 5");

      if (response.data['message']['success_key'] == 1) {
        // print("here 6");
        // print(response.data);
        // print('here');

        itemListResponse = ItemListResponse.getItemListResponseFromHttpResponse(response);
        print('here after this');
        print(itemListResponse);
        isAuthorized = true;
      }

      return isAuthorized ? itemListResponse : null;
    } catch (e) {
      throw new Exception('Error');
    }
  }
}
