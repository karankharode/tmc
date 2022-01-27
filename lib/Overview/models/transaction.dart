import 'package:dio/dio.dart';

class ItemListResponse {
  final List<Item> itemList;
  final int totalDocs;
  final int limit;
  final int totalPages;
  final int page;
  final int pageCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final int prevPage;
  final int nextPage;

  ItemListResponse({
    required this.totalDocs,
    required this.limit,
    required this.totalPages,
    required this.page,
    required this.pageCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.prevPage,
    required this.nextPage,
    required this.itemList,
  });

  factory ItemListResponse.getItemListResponseFromHttpResponse(
    Response<dynamic> response,
  ) {
    List<Item> tempItemList = [];
    // print('here 2');
    // print(response.data['message']['msg']);
    var data = response.data;
    for (var item in data['docs']) {
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
    int totalDocs = 0;
    int limit = 0;
    int totalPages = 0;
    int page = 0;
    int pageCounter = 0;
    bool hasPrevPage = false;
    bool hasNextPage = false;
    int prevPage = 0;
    int nextPage = 0;
    try {
      totalDocs = data["totalDocs"] ?? 0;
      limit = data['limit'] ?? 0;
      totalPages = data['totalPages'] ?? 0;
      page = data['page'] ?? 0;
      pageCounter = data['pageCounter'] ?? 0;
      hasPrevPage = data['hasPrevPage'] ?? false;
      hasNextPage = data['hasNextPage'] ?? false;
      prevPage = data['prevPage'] ?? 0;
      nextPage = data['nextPage'] ?? 0;
    } catch (e) {}

    print('here 3');
    return ItemListResponse(
        totalDocs: totalDocs,
        limit: limit,
        totalPages: totalPages,
        page: page,
        pageCounter: pageCounter,
        hasPrevPage: hasPrevPage,
        hasNextPage: hasNextPage,
        prevPage: prevPage,
        nextPage: nextPage,
        itemList: tempItemList);
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
