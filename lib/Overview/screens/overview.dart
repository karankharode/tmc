import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tmc/Overview/controllers/TransactionsController.dart';
import 'package:tmc/Overview/models/transaction.dart';
import 'package:tmc/constants/colors.dart';

bool dataFetched = false;
late ItemListResponse? itemListResponse;

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  DataTableSource _data = MyData();
  String? _chosenValue;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    itemListResponse = await ItemListController().getItems();
    if (itemListResponse != null) {
      setState(() {
        dataFetched = true;
      });
      print(itemListResponse);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryAccent,
      child: Column(
        children: [
          // the figures for transactions
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 18),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                  decoration: BoxDecoration(
                      color: statBoxColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: darkGrey)),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Failed Transaction",
                          style:
                              TextStyle(color: bgColor, fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                          child: Text(
                            "C1BCMC - 6969696",
                            style:
                                TextStyle(color: Colors.red, decoration: TextDecoration.underline),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                          child: Text(
                            "C1BCMC - 6969696",
                            style:
                                TextStyle(color: Colors.red, decoration: TextDecoration.underline),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                          child: Text(
                            "C1BCMC - 6969696",
                            style:
                                TextStyle(color: Colors.red, decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ]),
                ),
                Column(
                  children: [
                    overviewFigureWidget(failed: false),
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
                              color: Color(0xff8492A6), fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        onChanged: (String? value) {
                          if (value != null) {
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
                    overviewFigureWidget(failed: true),
                    Container(
                      width: 200,
                      height: 42,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.zero,
                          prefixIcon: Icon(
                            Icons.search,
                            color: grey,
                            size: 18,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Search Transaction',
                          hintText: 'Search Transactions',
                        ),
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
                source: _data,
                columns: [
                  DataColumn(
                    label: Text("ID"),
                  ),
                  DataColumn(label: Text("Service")),
                  DataColumn(label: Text("Timestamp")),
                  DataColumn(label: Text("Amount")),
                  DataColumn(label: Text("Status")),
                ],
                columnSpacing: ((MediaQuery.of(context).size.width - 30)) / 7,
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
}

class overviewFigureWidget extends StatelessWidget {
  const overviewFigureWidget({
    Key? key,
    required this.failed,
  }) : super(key: key);

  final bool failed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
          child: Row(
            children: [
              Text(
                !failed ? "Total Transactions" : "Total Failed Transactions",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3.0),
                child: Icon(Icons.calendar_today_outlined, size: 30),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
          child: Text(
            "690",
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
  // Generate some made-up data
  final List<Map<String, dynamic>> _data = List.generate(
      200, (index) => {"id": index + 1, "title": "Item $index", "price": Random().nextInt(10000)});

  bool get isRowCountApproximate => false;
  int get rowCount => _data.length;
  int get selectedRowCount => 0;
  DataRow getRow(int index) {
    return DataRow(
        color: MaterialStateProperty.all(index % 2 == 0 ? tableDarkColor : white),
        cells: [
          DataCell(Text(_data[index]['id'].toString())),
          DataCell(Text(_data[index]["title"])),
          DataCell(Text(_data[index]["price"].toString())),
          DataCell(Text(_data[index]['id'].toString())),
          DataCell(Text(_data[index]["title"])),
        ]);
  }
}
