import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tmc/Dashboard/controller/refreshToken.dart';
import 'package:tmc/LoginAndSignUp/modals/LoginResponse.dart';
import 'package:tmc/LoginAndSignUp/screens/LoginPage.dart';
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
  final LoginResponse loginResponse;
  String? currentPage = "overview";

  final double alertIconBoxheight = 40;

  late Timer _timer;

  Map<String, dynamic> body = {
    "overview": Overview(),
    "notification": NotificationsPage(),
  };

  _DashBoardState(this.loginResponse);

  @override
  void initState() {
    super.initState();
    print(loginResponse.token);
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  startTimer() {
    _timer = Timer(Duration(minutes: 30), () async {
      print(token);
      String refreshToken = await RefreshToken().refreshToken(token.toString());
      print(refreshToken);
      if (refreshToken == "Refresh Token created") {
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
    setState(() {
      currentPage = page;
    });
  }

  showSessionExpiredAlert() {
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
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(8, 35, 2, 8),
        child: Image.asset(
          'assets/branding/atx_logo.png',
          height: 100,
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
