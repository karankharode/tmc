import 'package:flutter/material.dart';
import 'package:tmc/LoginAndSignUp/screens/LoginPage.dart';
import 'package:tmc/LoginAndSignUp/screens/RegisterPage.dart';
import 'package:tmc/Notifications/screens/notifications.dart';
import 'package:tmc/Overview/screens/overview.dart';

import 'DrawerPage.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  String? currentPage = "overview";

  Map<String, dynamic> body = {
    "overview": Overview(),
    "notification": NotificationsPage(),
  };

  changePage(page) {
    setState(() {
      currentPage = page;
    });
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
