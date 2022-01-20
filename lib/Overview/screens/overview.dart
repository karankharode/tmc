// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:tmc/Overview/controllers/TransactionsController.dart';
import 'package:tmc/Overview/models/transaction.dart';
import 'package:tmc/constants/colors.dart';

bool dataFetched = false;
late ItemListResponse? itemListResponse;
late DataTableSource data;
int totaltransaction = 0;
int totalFailedtransaction = 0;

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> with AutomaticKeepAliveClientMixin<Overview> {
  String? _chosenValue;
  String? searchTerm;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    print('Get data');
    if (!dataFetched) {
      itemListResponse = await ItemListController().getItems();
      if (itemListResponse != null) {
        data = MyData(itemListResponse!);
        totaltransaction = itemListResponse!.itemList.length;
        int temp = 0;
        for (var i = 0; i < itemListResponse!.itemList.length; i++) {
          if (itemListResponse!.itemList[i].status.toString().toLowerCase() ==
              'Failed'.toLowerCase()) {
            temp = temp + 1;
          }
        }
        totalFailedtransaction = temp;
        setState(() {
          dataFetched = true;
        });

        print(itemListResponse);
      } else {}
    }
  }

  changeFilter(String value) {
    print(value);
    print(itemListResponse);
    if (value.toString().toLowerCase() != 'All Services'.toLowerCase()) {
      List<Item> tempList = itemListResponse?.itemList
              .where((element) =>
                  element.service.toString().toLowerCase() == value.toString().toLowerCase())
              .toList() ??
          [];
      data = MyData(ItemListResponse(itemList: tempList));
      totaltransaction = tempList.length;
      int temp = 0;
      for (var i = 0; i < tempList.length; i++) {
        if (tempList[i].status.toString().toLowerCase() == 'Failed'.toLowerCase()) {
          temp = temp + 1;
        }
      }
      totalFailedtransaction = temp;
    } else {
      data = MyData(itemListResponse!);
      totaltransaction = itemListResponse!.itemList.length;
      int temp = 0;
      for (var i = 0; i < itemListResponse!.itemList.length; i++) {
        if (itemListResponse!.itemList[i].status.toString().toLowerCase() ==
            'Failed'.toLowerCase()) {
          temp = temp + 1;
        }
      }
      totalFailedtransaction = temp;
    }
  }

  searchTransaction(value) {
    if (value.toString().trim().toLowerCase() != '') {
      List<Item> tempList = itemListResponse?.itemList
              .where((element) =>
                  element.id.toString().toLowerCase().contains(value.toString().toLowerCase()))
              .toList() ??
          [];
      data = MyData(ItemListResponse(itemList: tempList));
      totaltransaction = tempList.length;
      int temp = 0;
      for (var i = 0; i < tempList.length; i++) {
        if (tempList[i].status.toString().toLowerCase() == 'Failed'.toLowerCase()) {
          temp = temp + 1;
        }
      }
      totalFailedtransaction = temp;

      setState(() {});
    } else {
      data = MyData(itemListResponse!);
      totaltransaction = itemListResponse!.itemList.length;
      int temp = 0;
      for (var i = 0; i < itemListResponse!.itemList.length; i++) {
        if (itemListResponse!.itemList[i].status.toString().toLowerCase() ==
            'Failed'.toLowerCase()) {
          temp = temp + 1;
        }
      }
      totalFailedtransaction = temp;
      setState(() {});
    }
  }

  changeDate(DateTime selected) {
    print(selected.toString());

    List<Item> tempList = itemListResponse?.itemList
            .where((element) =>
                Jiffy(selected, 'yyyy-MM-dd hh:mm:ss').date.toString() ==
                Jiffy(element.timestamp.toString(), "yyyy/MM/dd hh:mm:ss").date.toString())
            .toList() ??
        [];
    data = MyData(ItemListResponse(itemList: tempList));

    totaltransaction = tempList.length;
    int temp = 0;
    for (var i = 0; i < tempList.length; i++) {
      if (tempList[i].status.toString().toLowerCase() == 'Failed'.toLowerCase()) {
        temp = temp + 1;
      }
    }
    totalFailedtransaction = temp;

    setState(() {});
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      changeDate(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryAccent,
      child: !dataFetched
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                // the figures for transactions
                Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 18),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Container(
                      //   padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                      //   decoration: BoxDecoration(
                      //       color: statBoxColor,
                      //       borderRadius: BorderRadius.all(Radius.circular(10)),
                      //       border: Border.all(color: darkGrey)),
                      //   child: Column(children: [
                      //     Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Text("Failed Transaction",
                      //           style:
                      //               TextStyle(color: bgColor, fontSize: 16, fontWeight: FontWeight.bold)),
                      //     ),
                      //     Column(
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                      //           child: Text(
                      //             "C1BCMC - 6969696",
                      //             style:
                      //                 TextStyle(color: Colors.red, decoration: TextDecoration.underline),
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                      //           child: Text(
                      //             "C1BCMC - 6969696",
                      //             style:
                      //                 TextStyle(color: Colors.red, decoration: TextDecoration.underline),
                      //           ),
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                      //           child: Text(
                      //             "C1BCMC - 6969696",
                      //             style:
                      //                 TextStyle(color: Colors.red, decoration: TextDecoration.underline),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ]),
                      // ),
                      Column(
                        children: [
                          overviewFigureWidget(
                            failed: false,
                            figure: totaltransaction,
                            selectDate: () {
                              _selectDate(context);
                            },
                          ),
                          // filter
                          Container(
                            padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                            width: 182,
                            height: 42,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff8492A6), width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(5))),
                            child: DropdownButton<String>(
                              focusColor: Colors.white,

                              value: _chosenValue,
                              //elevation: 5,
                              isExpanded: true,
                              style: TextStyle(color: Colors.white),
                              iconEnabledColor: Colors.black,
                              underline: Container(),
                              items: <String>[
                                "All Services",
                                "GoPay",
                                "Mypospay",
                                "Runcit Hero",
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Color(0xff8492A6)),
                                  ),
                                );
                              }).toList(),
                              hint: Text(
                                "Select Service",
                                style: TextStyle(
                                    color: Color(0xff8492A6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                              onChanged: (String? value) {
                                if (value != null) {
                                  changeFilter(value);
                                  setState(() {
                                    _chosenValue = value;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          overviewFigureWidget(
                            failed: true,
                            figure: totalFailedtransaction,
                            selectDate: () {
                              _selectDate(context);
                            },
                          ),
                          Container(
                            width: 220,
                            height: 42,
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                alignLabelWithHint: true,
                                contentPadding: EdgeInsets.zero,
                                hintStyle: TextStyle(overflow: TextOverflow.clip),
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    print("Prefix pressed");
                                    searchTransaction(searchTerm);
                                  },
                                  icon: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                ),
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                labelText: 'Search Transactions',
                                hintText: 'Search Transactions',
                              ),
                              onChanged: (value) {
                                print(searchTerm);
                                searchTerm = value;
                                if (value.isEmpty) {
                                  searchTransaction('');
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // table for transactions
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 2),
                  child: Container(
                    child: PaginatedDataTable(
                      source: data,
                      columns: [
                        DataColumn(
                          label: Text("ID"),
                        ),
                        DataColumn(label: Text("Service")),
                        DataColumn(label: Text("Timestamp")),
                        DataColumn(label: Text("Amount")),
                        DataColumn(label: Text("Status")),
                      ],
                      columnSpacing: ((MediaQuery.of(context).size.width - 30)) / 8.5,
                      showFirstLastButtons: true,
                      horizontalMargin: 20,
                      rowsPerPage: 5,
                      showCheckboxColumn: false,
                    ),
                  ),
                ))
              ],
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class overviewFigureWidget extends StatelessWidget {
  const overviewFigureWidget({
    Key? key,
    required this.selectDate,
    required this.figure,
    required this.failed,
  }) : super(key: key);

  final bool failed;
  final int figure;
  final Function selectDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
          child: Row(
            children: [
              Text(
                (!failed) ? "Total Transactions" : "Total Failed Transactions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Stack(
                  children: [
                    Positioned(
                      left: 10.5,
                      top: 10.5,
                      child: Icon(
                        Icons.calendar_today_outlined,
                        size: 22,
                        color: Colors.black54,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          selectDate();
                        },
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          Icons.calendar_today_outlined,
                          size: 22,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
          child: Text(
            figure.toString(),
            style: TextStyle(
                color: !failed ? Colors.green : Colors.red,
                fontWeight: FontWeight.w900,
                fontSize: 36),
          ),
        ),
      ],
    );
  }
}

class MyData extends DataTableSource {
  final ItemListResponse _data;
  MyData(this._data);
  // Generate some made-up data
  // final List<Map<String, dynamic>> _data = List.generate(
  //     200, (index) => {"id": index + 1, "title": "Item $index", "price": Random().nextInt(10000)});

  bool get isRowCountApproximate => false;
  int get rowCount => _data.itemList.length;

  int get selectedRowCount => 0;
  DataRow getRow(int index) {
    return DataRow(
        color: MaterialStateProperty.all(index % 2 == 0 ? tableDarkColor : white),
        cells: [
          DataCell(Text(_data.itemList[index].id.toString())),
          DataCell(Text(_data.itemList[index].service.toString())),
          DataCell(Text(_data.itemList[index].timestamp.toString())),
          DataCell(Text(_data.itemList[index].amount.toString())),
          DataCell(Text(_data.itemList[index].status.toString())),
        ]);
  }
}
