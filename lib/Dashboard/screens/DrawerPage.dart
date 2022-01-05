import 'package:flutter/material.dart';
import 'package:tmc/Dashboard/widgets/customTile.dart';

class Drawerpage extends StatefulWidget {
  final Function changepage;
  final String? currentPage;
  const Drawerpage({Key? key, required this.changepage, required this.currentPage})
      : super(key: key);

  @override
  _DrawerpageState createState() => _DrawerpageState();
}

class _DrawerpageState extends State<Drawerpage> {
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
        customtile(
            txt: "Notification",
            current: widget.currentPage == "notification",
            onTap: () {
              widget.changepage("notification");
            }),
        customtile(txt: "Logout", current: widget.currentPage == "logout", onTap: () {}),
      ],
    );
  }
}
