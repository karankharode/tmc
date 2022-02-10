// ignore_for_file: camel_case_types

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:tmc/Notifications/controller/UpdateController.dart';
import 'package:tmc/Notifications/modals/TransactionById.dart';
import 'package:tmc/constants/colors.dart';
import 'package:tmc/constants/config.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  DateTime selectedDate = DateTime.now();
  bool dateSelected = false;
  String tempStatus = 'Failed';

  String? searchTerm = "";
  List seenIndexes = [];

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateSelected = true;
      });
    else {
      setState(() {
        dateSelected = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  final double alertIconBoxheight = 40;

  getData(String id) async {
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
                                    setState(() {
                                      tempStatus = status;
                                    });
                                    bool isUpdated =
                                        await UpdateController().updateItem(id, status);
                                    Navigator.pop(context);
                                    Navigator.pop(context);

                                    if (isUpdated) {
                                      showHurrayDialog(status, id);
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
                              "Select Service",
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
      child: Column(
        children: [
          // top search row
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 18, bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // search bar
                Container(
                  width: 220,
                  height: 42,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                      contentPadding: EdgeInsets.only(left: 7),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {});
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
                      labelText: 'Search Notification',
                      hintText: 'Search Notification',
                    ),
                    onChanged: (value) {
                      // print(searchTerm);
                      searchTerm = value;
                      // setState(() {});
                    },
                  ),
                ),

                // date field
                Container(
                  width: 200,
                  height: 42,
                  child: Stack(
                    children: [
                      TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          enabled: true,

                          border: OutlineInputBorder(),
                          alignLabelWithHint: true,
                          contentPadding: EdgeInsets.only(left: 16),
                          // suffixIcon:
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: dateSelected ? selectedDate.toString() : "Select Date",
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            _selectDate(context);
                          },
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.black,
                            size: 28,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: FirebaseAnimatedList(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                reverse: false,
                sort: (a, b) => b.key!.compareTo(a.key!),
                query: FirebaseDatabase.instance
                    .ref()
                    .child('notifications')
                    .orderByChild("timestamps"),
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map mydata = snapshot.value as Map;
                  String id = mydata['id'];
                  String timestamp = mydata['timestamp'];
                  DateTime transactionDate = DateTime.parse(timestamp);

                  try {
                    timestamp = timestamp.replaceFirst("Z", "").split("T").join(" ").toString();
                  } catch (e) {}

                  bool seen = seenIndexes.contains(index) || (index) >= notificationCount;
                  // print(id);
                  if (searchTerm != "" || searchTerm != null) {
                    if (!id.toString().toLowerCase().contains(searchTerm!.toLowerCase())) {
                      return Container();
                    }
                  }
                  if (dateSelected) {
                    // print("true");
                    if ("${selectedDate.day.toString()}-${selectedDate.month.toString()}-${selectedDate.year.toString()}" !=
                        "${transactionDate.day.toString()}-${transactionDate.month.toString()}-${transactionDate.year.toString()}") {
                      return Container();
                    }
                  }

                  return Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: index % 2 == 0 ? tableDarkColor : white,
                        border: Border.symmetric(horizontal: BorderSide(color: grey, width: 0.5))),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              child: Center(
                                child: seen
                                    ? Container(
                                        height: 7,
                                      )
                                    : Container(
                                        height: 7,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle, color: notifierColor)),
                              ),
                            )),
                        Expanded(
                            flex: 12,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Alert - Transaction has Failed!',
                                      style: TextStyle(
                                        color: seen ? Colors.black87 : notifierColor,
                                        fontWeight: seen ? FontWeight.w400 : FontWeight.w600,
                                        fontSize: 13,
                                      )),
                                  Row(
                                    children: [
                                      Text('Transaction ID $id has been failed.',
                                          style: TextStyle(
                                            fontSize: 12,
                                          )),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            seenIndexes.add(index);
                                          });
                                          getData(id.toString());
                                        },
                                        child: Text(' View transaction Details...',
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                decoration: TextDecoration.underline)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 3,
                            child: Container(
                              child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 14),
                                    child: Text(
                                      timestamp.toString(),
                                      style: TextStyle(
                                          color: bgColor,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  )),
                            )),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class loader extends StatelessWidget {
  const loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 38.0),
      child: Center(child: CircularProgressIndicator()),
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
