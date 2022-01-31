import 'dart:html';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmc/Dashboard/widgets/customTile.dart';
import 'package:tmc/LoginAndSignUp/screens/LoginPage.dart';
import 'package:tmc/constants/colors.dart';

class Drawerpage extends StatefulWidget {
  final Function changepage;
  final String? currentPage;
  final int notificationCount;
  const Drawerpage({
    Key? key,
    required this.changepage,
    required this.currentPage,
    required this.notificationCount,
  }) : super(key: key);

  @override
  _DrawerpageState createState() => _DrawerpageState(notificationCount);
}

class _DrawerpageState extends State<Drawerpage> {
  final int notificationCount;

  _DrawerpageState(this.notificationCount);
  @override
  Widget build(BuildContext context) {
    return Column(
      //shrinkWrap: true,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        customtile(
            txt: "Dashboard Overview",
            current: widget.currentPage == "overview",
            onTap: () {
              widget.changepage("overview");
            }),
        Material(
          elevation: 1,
          //borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
          child: InkWell(
            onTap: () {
              widget.changepage("notification");
            },
            child: ListTile(
                //  contentPadding: EdgeInsets.fromLTRB(10, 3, 3, 3),
                tileColor: widget.currentPage == "notification" ? tableDarkColor : bgColor,
                title: Row(
                  children: [
                    Text(
                      "Notification",
                      style: GoogleFonts.ubuntu(
                        fontSize: 15,
                        color: widget.currentPage == "notification" ? Colors.black : Colors.white,
                        fontWeight: widget.currentPage == "notification"
                            ? FontWeight.bold
                            : FontWeight.w400,
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                        'assets/images/red_bell.png',
                      ))),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 4.0),
                          child: Text(
                            '${widget.notificationCount.toString()}',
                            style: TextStyle(
                                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
        customtile(
            txt: "Logout",
            current: widget.currentPage == "logout",
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            }),
      ],
    );
  }
}
