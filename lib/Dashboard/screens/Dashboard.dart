import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tmc/Dashboard/controller/refreshToken.dart';
import 'package:tmc/LoginAndSignUp/modals/LoginResponse.dart';
import 'package:tmc/LoginAndSignUp/screens/LoginPage.dart';
import 'package:tmc/Notifications/controller/UpdateController.dart';
import 'package:tmc/Notifications/modals/TransactionById.dart';
import 'package:tmc/Notifications/screens/notifications.dart';
import 'package:tmc/Overview/screens/overview.dart';
import 'package:tmc/constants/colors.dart';
import 'package:tmc/constants/config.dart';

import 'DrawerPage.dart';

class DashBoard extends StatefulWidget {
  final LoginResponse loginResponse;
  const DashBoard({Key? key, required this.loginResponse}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState(loginResponse);
}

class _DashBoardState extends State<DashBoard> {
  _DashBoardState(this.loginResponse);
  final LoginResponse loginResponse;
  String? currentPage = "overview";

  final double alertIconBoxheight = 40;

  late Timer _timer;

  Map<String, dynamic> body = {
    "overview": Overview(),
    "notification": NotificationsPage(),
  };

  // int failedTransactionCount = 0;
  bool isInitialDataLoaded = false;

  var ref = FirebaseDatabase.instance.ref().child("notifications");
  var sub1;

  @override
  void initState() {
    super.initState();
    // print(loginResponse.token);
    startTimer();
    setListener();
  }

  @override
  void dispose() {
    super.dispose();
    sub1.cancel();
    _timer.cancel();
  }

  setListener() async {
    await ref.once().then((value) {
      isInitialDataLoaded = true;
    });

    sub1 = ref.limitToLast(1).onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      if (isInitialDataLoaded) {
        setState(() {
          notificationCount = notificationCount + 1;
        });
        onAddedAction(event);
      }
    });
  }

  onAddedAction(DatabaseEvent event) {
    Map mydata = event.snapshot.value as Map;
    String id = mydata['id'];
    String timestamp = mydata['timestamp'];
    setState(() {});
    showCustomAlert("Alert-Transaction Failed!", "Transaction ID $id has failed", id);
  }

  showCustomAlert(String heading, String text, String id) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Container();
      },
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.2),
      barrierLabel: '',
      transitionBuilder: (context, a1, a2, widget) {
        final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
        return Transform(
          transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
          child: Opacity(
            opacity: a1.value,
            child: AlertDialog(
              insetPadding: EdgeInsets.fromLTRB(40, 5, 0, 0),
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
                                          color: Color(0xff0481B3),
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
                                    padding:
                                        EdgeInsets.only(left: alertIconBoxheight + 5, bottom: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          heading,
                                          style: TextStyle(
                                              color: Color(0xff0481B3),
                                              fontWeight: FontWeight.w300),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('Transaction ID ',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )),
                                            Text('$id',
                                                style: TextStyle(fontSize: 12, color: Colors.red)),
                                            Text(' has failed. ',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                )),
                                            InkWell(
                                              onTap: () {
                                                setState(() {});

                                                getData(id.toString());
                                              },
                                              child: Text('View transaction Details.',
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    // fontWeight: FontWeight.w600,
                                                    decoration: TextDecoration.underline,
                                                    fontSize: 12,
                                                  )),
                                            ),
                                          ],
                                        )
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
                              color: Color(0xff0481B3),
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

  getData(String id) async {
    Navigator.pop(context);
    showcircularPI();
    ItemResponse? itemResponse = await UpdateController().getItemById(id);
    Navigator.pop(context);
    showTransactionDetails(itemResponse!);
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
                                    await UpdateController().updateItem(id, status);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    showHurrayDialog(status, id);
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
              dataColumn(heading: "Timestamp", value: itemResponse.item.timestamp.toString()),
            ],
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }

  startTimer() {
    _timer = Timer(Duration(minutes: 30), () async {
      print(token);
      String refreshToken = await RefreshToken().refreshToken(token.toString());
      print(refreshToken);
      if (refreshToken != "Error") {
        setState(() {
          token = refreshToken;
        });
        startTimer();
        print('token Refreshed');
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(pageBuilder: (_, __, ___) => new LoginPage()), (route) => false);
        showSessionExpiredAlert();
        print("Ranu your session has timed out...refreshing!");
        print('Not Logged IN');
      }
    });
  }

  changePage(page) {
    if (currentPage == "notification" && page == "overview") {
      notificationCount = 0;
    }
    setState(() {
      currentPage = page;
    });
  }

  showSessionExpiredAlert() {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(pageBuilder: (_, __, ___) => new LoginPage()), (route) => false);
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
              alignment: Alignment.center,
              contentPadding: EdgeInsets.zero,
              content: Container(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(22), color: Colors.white),
                    width: MediaQuery.of(context).size.width / 1.7,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(22), topRight: Radius.circular(22))),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8, 30, 8, 30.0),
                                child: Center(
                                    child: Image.asset(
                                  "assets/images/alertInTriangle.png",
                                  height: alertIconBoxheight * 2 + 20,
                                  width: alertIconBoxheight * 2 + 20,
                                )),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: alertIconBoxheight / 2 + 5,
                                  right: alertIconBoxheight / 2 + 5,
                                  top: 30,
                                  bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 30),
                                    child: Text(
                                      "Oops! Session expired. You have been logged out.",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Please login again.",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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

  @override
  Widget build(BuildContext context) {
    print("notification count : $notificationCount");
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(8, 35, 2, 8),
        child: InkWell(
          onTap: () => showSessionExpiredAlert(),
          child: Image.asset(
            'assets/branding/atx_logo.png',
            height: 100,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartDocked,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/background.jpg',
                ),
                fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 14, 8, 14),
                child: Text(
                  'TMC',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 80),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              width: MediaQuery.of(context).size.width - 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Drawerpage(
                      changepage: changePage,
                      currentPage: currentPage,
                      notificationCount: notificationCount,
                    ),
                  ),
                  Expanded(flex: 4, child: body[currentPage])
                ],
              ),
            ),
          ],
        ),
      ),
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
