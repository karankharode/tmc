import 'package:dio/dio.dart';
import 'package:tmc/Overview/models/transaction.dart';

class ItemResponse {
  final Item item;

  ItemResponse({
    required this.item,
  });

  factory ItemResponse.getItemResponseFromHttpResponse(
    Response<dynamic> response,
  ) {
    // print('here 2');
    // print(response.data['message']['msg']);
    var item = response.data;

    return ItemResponse(
      item: Item(
        id: item['_id'],
        service: item['service'],
        timestamp: item['timestamp'],
        amount: item['amount'],
        status: item['status'],
        v: item['__v'],
      ),
    );
  }
}
