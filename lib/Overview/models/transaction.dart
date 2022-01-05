import 'package:dio/dio.dart';

class ItemListResponse {
  final List<Item> itemList;

  ItemListResponse({
    required this.itemList,
  });

  factory ItemListResponse.getItemListResponseFromHttpResponse(
    Response<dynamic> response,
  ) {
    List<Item> tempItemList = [];
    // print('here 2');
    // print(response.data['message']['msg']);
    var data = response.data;
    for (var item in data) {
      print(item);
      tempItemList.add(Item(
        id: item['_id'],
        service: item['service'],
        timestamp: item['timestamp'],
        amount: item['amount'],
        status: item['status'],
        v: item['__v'],
      ));
    }
    print('here 3');
    return ItemListResponse(
      itemList: tempItemList,
    );
  }
}

class Item {
  final String id;
  final String service;
  final String timestamp;
  final double amount;
  final String status;
  final int v;

  Item({
    required this.id,
    required this.service,
    required this.timestamp,
    required this.amount,
    required this.status,
    required this.v,
  });
}
