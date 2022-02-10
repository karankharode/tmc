// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';
import 'package:tmc/Notifications/controller/UpdateController.dart';
import 'package:tmc/Notifications/modals/TransactionById.dart';
import 'package:tmc/Overview/controllers/TransactionsController.dart';
import 'package:tmc/Overview/models/transaction.dart';
import 'package:tmc/constants/colors.dart';

bool dataFetched = false;
late ItemListResponse? itemListResponse;
late DataTableSource data;
int totaltransaction = 0;
// int totalFailedtransaction = 0;

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  String? _chosenValue = '';
  String? searchTerm = "";
  DateTime selectedDate = DateTime.now();
  DateTime endDate = DateTime.now();
  bool startDateSelected = false;
  bool endDateSelected = false;

  @override
  void initState() {
    super.initState();
    getData(1, 5);
  }

  getData(int page, int limit,
      {String keyword = '',
      String source_service = '',
      String start_date = '',
      String end_Date = ''}) async {
    String startDateString = '';
    String endDateString = '';
    try {
      if (startDateSelected) {
        startDateString = selectedDate.year.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.day.toString();
      }
    } catch (e) {
      startDateString = '';
    }
    try {
      if (endDateSelected) {
        endDateString =
            endDate.year.toString() + "-" + endDate.month.toString() + "-" + endDate.day.toString();
      }
    } catch (e) {
      endDateString = '';
    }
    itemListResponse = await ItemListController().getItems(page, limit,
        keyword: keyword,
        source_service: source_service,
        start_date: startDateSelected ? startDateString : '',
        end_Date: endDateSelected ? endDateString : '');

    if (itemListResponse!.totalDocs == -1 ||
        itemListResponse!.totalDocs == -2 ||
        itemListResponse!.totalDocs == -3) {
      setState(() {
        dataFetched = false;
      });
      showCustomAlert(
          "Oops! An error occured", "Request to view transaction is denied Please try again.");
    } else if (itemListResponse != null) {
      data = MyData(itemListResponse!);
      totaltransaction = itemListResponse!.itemList.length;
      setState(() {
        dataFetched = true;
      });

      // print(itemListResponse);
    }
  }

  showCustomAlert(String heading, String text) {
    print(text);
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrollable: true,
              alignment: Alignment.topCenter,
              contentPadding: EdgeInsets.zero,
              content: Container(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: alertIconBoxheight / 2),
                            child: Container(
                              color: white,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        height: 10,
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: alertIconBoxheight / 2 + 5, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          heading,
                                          style: TextStyle(
                                              color: colorSecondary, fontWeight: FontWeight.w300),
                                        ),
                                        Text(text),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: alertIconBoxheight,
                            width: alertIconBoxheight * 2.5,
                            decoration: BoxDecoration(
                              color: colorSecondary,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            child: Center(
                                child: Image.asset(
                              "assets/images/alert.png",
                              height: alertIconBoxheight - 5,
                              width: alertIconBoxheight - 5,
                            )),
                          ),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                                icon: Icon(Icons.cancel_outlined, color: Colors.black),
                                onPressed: () {
                                  Navigator.pop(context);
                                })),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;

        startDateSelected = true;
      });

      // changeDate(selectedDate);
    } else {
      setState(() {
        startDateSelected = false;
      });
    }
    getData(
      1,
      5,
      keyword: searchTerm!,
      source_service:
          _chosenValue!.toLowerCase() != "All Services".toLowerCase() ? _chosenValue ?? "" : "",
      start_date: startDateSelected ? selectedDate.toString() : "",
      end_Date: endDateSelected ? endDate.toString() : "",
    );
  }

  Future<Null> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        endDate = picked;
        endDateSelected = true;
      });

      // changeDate(selectedDate);
    } else {
      setState(() {
        endDateSelected = false;
      });
    }
    getData(
      1,
      5,
      keyword: searchTerm!,
      source_service:
          _chosenValue!.toLowerCase() != "All Services".toLowerCase() ? _chosenValue ?? "" : "",
      start_date: startDateSelected ? selectedDate.toString() : "",
      end_Date: endDateSelected ? endDate.toString() : "",
    );
  }

  Stack buildCalendarIcon(bool start) {
    return Stack(
      children: [
        Positioned(
          left: 10,
          top: 10,
          child: Icon(
            Icons.calendar_today_outlined,
            size: 22,
            color: Colors.black54,
          ),
        ),
        IconButton(
            onPressed: () {
              start ? _selectDate(context) : _selectEndDate(context);
            },
            padding: EdgeInsets.zero,
            icon: Icon(
              Icons.calendar_today_outlined,
              size: 22,
            )),
      ],
    );
  }

  final double alertIconBoxheight = 40;

  getStatusColor(String status) {
    switch (status) {
      case "Failed":
        return Colors.red;
      case "Success":
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  getDataForSingleitem(String id) async {
    showcircularPI();
    ItemResponse? itemResponse = await UpdateController().getItemById(id);
    Navigator.pop(context);
    if (itemResponse!.item.id == "no internet") {
      showCustomAlert(
          "Oops! An error occured", "Request to view transaction is denied Please try again.");
    } else {
      showTransactionDetails(itemResponse);
    }
  }

  showcircularPI() {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              // scrollable: true,
              content: Container(
                width: MediaQuery.of(context).size.width / 1.8,
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
    );
  }

  showTransactionDetails(ItemResponse itemResponse) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              // scrollable: true,
              content: Container(
                width: MediaQuery.of(context).size.width / 1.8,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: alertIconBoxheight / 2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: Color(0xff0481B3), width: 8),
                        borderRadius: BorderRadius.all(Radius.circular(53)),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 25,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey, width: 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('TRANSACTION DETAILS'),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                        icon: Icon(Icons.cancel_outlined, color: Colors.black),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        })),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          buildDetails(itemResponse)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
    );
  }

  showConfirmation(String status, String id) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              // scrollable: true,
              content: Container(
                width: MediaQuery.of(context).size.width / 2.7,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: alertIconBoxheight / 2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Confirm',
                                    style: TextStyle(
                                      color: Colors.black87,
                                    )),
                                IconButton(
                                    icon: Icon(Icons.cancel_outlined, color: Colors.black),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    })
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 30),
                            child: Text(
                                "Are you sure you want tp update the transaction status to $status?"),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("No, Cancel"),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    bool isUpdated =
                                        await UpdateController().updateItem(id, status);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    if (isUpdated) {
                                      showHurrayDialog(status, id);
                                      getData(
                                        (itemListResponse?.page ?? 1),
                                        5,
                                        source_service: _chosenValue!.toLowerCase() !=
                                                "All Services".toLowerCase()
                                            ? _chosenValue ?? ""
                                            : "",
                                        keyword: searchTerm != "" ? searchTerm! : "",
                                        start_date:
                                            startDateSelected ? selectedDate.toString() : "",
                                        end_Date: endDateSelected ? endDate.toString() : "",
                                        // source_service: _chosenValue != null ? _chosenValue! : "",
                                      );
                                    } else {
                                      showCustomAlert(
                                          "Uh oh, something went wrong! There is a problem with your status update.",
                                          "Status update for Transaction ID $id was unsuccessful. Please try again.");
                                    }
                                  },
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.green)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("Yes, Update"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
    );
  }

  showHurrayDialog(String status, String id) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.4),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              contentPadding: EdgeInsets.zero,
              scrollable: true,
              alignment: Alignment.center,
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/celebration.png',
                    height: 70,
                    fit: BoxFit.fitHeight,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2.7,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: alertIconBoxheight / 2,
                            right: alertIconBoxheight / 2,
                            top: 20,
                            bottom: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Hooray! Status for transaction ID $id is $status",
                              style: TextStyle(
                                  color: Colors.green, fontWeight: FontWeight.w800, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
    );
  }

  Padding buildDetails(ItemResponse itemResponse) {
    String timestamp = itemResponse.item.timestamp;
    try {
      timestamp = itemResponse.item.timestamp
          .toString()
          .replaceFirst("Z", "")
          .split("T")
          .join(" ")
          .toString();
    } catch (e) {}
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dataColumn(heading: "Transaction ID", value: itemResponse.item.id.toString()),
              dataColumn(heading: "Service", value: itemResponse.item.service.toString()),
              Expanded(
                flex: 1,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 18, 8, 18),
                    child: Column(
                      children: [
                        Text(
                          "Status",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                          width: 132,
                          height: 35,
                          decoration: BoxDecoration(
                              border: Border.all(color: Color(0xff8492A6), width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(5))),
                          child: DropdownButton<String>(
                            focusColor: Colors.red,
                            value: itemResponse.item.status,
                            //elevation: 5,
                            isExpanded: true,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.black,
                            underline: Container(),
                            items: <String>[
                              "Success",
                              "Failed",
                              "Pending",
                              "Cancelled",
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Container(
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Color(0xff8492A6)),
                                  ),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              "Select Status",
                              style: TextStyle(
                                  color: Color(0xff8492A6),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String? val) {
                              if (val != null) {
                                showConfirmation(val, itemResponse.item.id);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              dataColumn(heading: "Amount", value: itemResponse.item.amount.toString()),
              dataColumn(heading: "Timestamp", value: timestamp),
            ],
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
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
                      Column(
                        children: [
                          overviewFigureWidget(
                            failed: false,
                            figure: itemListResponse?.totalDocs ?? 0,
                            selectDate: () {
                              _selectDate(context);
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          // filter
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                              width: 220,
                              height: 42,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xff8492A6), width: 1),
                                  borderRadius: BorderRadius.all(Radius.circular(5))),
                              child: DropdownButton<String>(
                                focusColor: Colors.white,
                                value: _chosenValue != '' ? _chosenValue : null,
                                isExpanded: true,
                                style: TextStyle(color: Colors.white),
                                iconEnabledColor: Colors.black,
                                underline: Container(),
                                items: <String>[
                                  "All Services",
                                  "mypospay",
                                  "Gopay",
                                  "Gopayz",
                                  "Runcit Hero",
                                  "Mobicare",
                                  "Policystreet",
                                  "Covid Test",
                                  "Flexiparking",
                                  "wallet"
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
                                    // changeFilter(value);
                                    setState(() {
                                      _chosenValue = value;
                                    });
                                    if (_chosenValue!.toLowerCase() !=
                                        "All Services".toLowerCase()) {
                                      getData(
                                        1,
                                        5,
                                        source_service: _chosenValue ?? "",
                                        start_date:
                                            startDateSelected ? selectedDate.toString() : "",
                                        end_Date: endDateSelected ? endDate.toString() : "",
                                      );
                                    } else {
                                      getData(
                                        1,
                                        5,
                                        start_date:
                                            startDateSelected ? selectedDate.toString() : "",
                                        end_Date: endDateSelected ? endDate.toString() : "",
                                      );
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              width: 220,
                              height: 42,
                              child: Stack(
                                children: [
                                  TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      enabled: false,
                                      border: OutlineInputBorder(),
                                      alignLabelWithHint: true,
                                      suffixIconConstraints: BoxConstraints(
                                        minHeight: 26,
                                        maxHeight: 28,
                                        minWidth: 26,
                                        maxWidth: 28,
                                      ),
                                      contentPadding: EdgeInsets.only(left: 14),
                                      // suffixIcon: buildCalendarIcon(true),
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                      hintText: startDateSelected
                                          ? (selectedDate.year.toString() +
                                              "-" +
                                              selectedDate.month.toString() +
                                              "-" +
                                              selectedDate.day.toString())
                                          : "Start Date",
                                    ),
                                  ),
                                  Positioned(right: 0, child: buildCalendarIcon(true))
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              width: 220,
                              height: 42,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  alignLabelWithHint: true,
                                  contentPadding: EdgeInsets.only(left: 7),
                                  hintStyle: TextStyle(overflow: TextOverflow.clip),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      // print("Prefix pressed");
                                      getData(
                                        1,
                                        5,
                                        keyword: searchTerm!,
                                        source_service: _chosenValue!.toLowerCase() !=
                                                "All Services".toLowerCase()
                                            ? _chosenValue ?? ""
                                            : "",
                                        start_date:
                                            startDateSelected ? selectedDate.toString() : "",
                                        end_Date: endDateSelected ? endDate.toString() : "",
                                      );
                                      // searchTransaction(searchTerm);
                                    },
                                    icon: Container(
                                      color: Colors.black,
                                      padding: EdgeInsets.all(3),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 1.5,
                                            top: 1.5,
                                            child: Icon(
                                              Icons.search,
                                              color: Colors.white70,
                                              size: 18,
                                            ),
                                          ),
                                          Icon(
                                            Icons.search,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.never,
                                  labelText: 'Search Transactions',
                                  hintText: 'Search Transactions',
                                ),
                                onChanged: (value) {
                                  // print(searchTerm);
                                  searchTerm = value;
                                  if (value.isEmpty) {
                                    // searchTransaction('');
                                  }
                                },
                                onEditingComplete: () {
                                  getData(
                                    1,
                                    5,
                                    keyword: searchTerm!,
                                    source_service:
                                        _chosenValue!.toLowerCase() != "All Services".toLowerCase()
                                            ? _chosenValue ?? ""
                                            : "",
                                    start_date: startDateSelected ? selectedDate.toString() : "",
                                    end_Date: endDateSelected ? endDate.toString() : "",
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              width: 220,
                              height: 42,
                              child: Stack(
                                children: [
                                  TextField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      enabled: true,

                                      border: OutlineInputBorder(),
                                      alignLabelWithHint: true,
                                      suffixIconConstraints: BoxConstraints(
                                        minHeight: 26,
                                        maxHeight: 28,
                                        minWidth: 26,
                                        maxWidth: 28,
                                      ),
                                      contentPadding: EdgeInsets.only(left: 14),
                                      // suffixIcon: buildCalendarIcon(false),
                                      floatingLabelBehavior: FloatingLabelBehavior.never,
                                      hintText: endDateSelected
                                          ? (endDate.year.toString() +
                                              "-" +
                                              endDate.month.toString() +
                                              "-" +
                                              endDate.day.toString())
                                          : "End Date",
                                    ),
                                  ),
                                  Positioned(right: 0, child: buildCalendarIcon(false))
                                ],
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
                    child: Column(
                      children: [
                        DataTable(
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
                          // showFirstLastButtons: false,
                          rows: [
                            ...itemListResponse!.itemList.map((e) {
                              int index = itemListResponse!.itemList.indexOf(e);
                              Item _data = e;
                              String timestamp = e.timestamp;
                              try {
                                timestamp = e.timestamp
                                    .replaceFirst("Z", "")
                                    .split("T")
                                    .join(" ")
                                    .toString();
                              } catch (e) {}

                              return DataRow(
                                color: MaterialStateProperty.all(
                                    index % 2 == 0 ? tableDarkColor : white),
                                cells: [
                                  DataCell(InkWell(
                                      onTap: () {
                                        getDataForSingleitem(e.id.toString());
                                      },
                                      child: Text(e.id.toString()))),
                                  DataCell(InkWell(
                                      onTap: () {
                                        getDataForSingleitem(e.id.toString());
                                      },
                                      child: Text(e.service.toString()))),
                                  DataCell(InkWell(
                                      onTap: () {
                                        getDataForSingleitem(e.id.toString());
                                      },
                                      child: Text(timestamp.toString()))),
                                  DataCell(InkWell(
                                      onTap: () {
                                        getDataForSingleitem(e.id.toString());
                                      },
                                      child: Text(e.amount.toString()))),
                                  DataCell(InkWell(
                                      onTap: () {
                                        getDataForSingleitem(e.id.toString());
                                      },
                                      child: Text(
                                        e.status.toString(),
                                        style: TextStyle(color: getStatusColor(e.status)),
                                      ))),
                                ],
                              );
                            })
                          ],

                          horizontalMargin: 20,
                          showCheckboxColumn: false,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Page ${itemListResponse?.page ?? 1}",
                              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                onPressed: () {
                                  if (itemListResponse!.hasPrevPage) {
                                    // print(itemListResponse!.prevPage);
                                    getData(
                                      (itemListResponse?.prevPage ?? 2),
                                      5,
                                      keyword: searchTerm != "" ? searchTerm! : "",
                                      source_service: _chosenValue!.toLowerCase() !=
                                              "All Services".toLowerCase()
                                          ? _chosenValue ?? ""
                                          : "",
                                      start_date: startDateSelected ? selectedDate.toString() : "",
                                      end_Date: endDateSelected ? endDate.toString() : "",
                                      // source_service: _chosenValue != null ? _chosenValue! : "",
                                    );
                                  }
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: itemListResponse!.hasPrevPage ? Colors.black : Colors.grey,
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            IconButton(
                                onPressed: () {
                                  if (itemListResponse!.hasNextPage) {
                                    // print(itemListResponse!.nextPage);
                                    getData(
                                      itemListResponse?.nextPage ?? 2,
                                      5,
                                      source_service: _chosenValue!.toLowerCase() !=
                                              "All Services".toLowerCase()
                                          ? _chosenValue ?? ""
                                          : "",
                                      keyword: searchTerm != "" ? searchTerm! : "",
                                      start_date: startDateSelected ? selectedDate.toString() : "",
                                      end_Date: endDateSelected ? endDate.toString() : "",
                                    );
                                  }
                                },
                                icon: Icon(Icons.arrow_forward_ios,
                                    color: itemListResponse!.hasNextPage
                                        ? Colors.black
                                        : Colors.grey)),
                            SizedBox(
                              width: 15,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
    );
  }

  // @override
  // bool get wantKeepAlive => true;
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

class dataColumn extends StatelessWidget {
  const dataColumn({Key? key, required this.heading, required this.value}) : super(key: key);
  final String heading;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 18, 8, 18),
          child: Column(
            children: [
              Text(
                heading,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                value,
                style: TextStyle(
                  color: Color(0xaa47525E),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
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
