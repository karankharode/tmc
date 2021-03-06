import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmc/constants/colors.dart';

Widget customtile({String txt = "custom", onTap, bool current = false}) {
// FirebaseAuth _auth = FirebaseAuth.instance;
  return Material(
    elevation: 1,
    //borderRadius: BorderRadius.all(Radius.elliptical(10, 10)),
    child: InkWell(
      onTap: onTap,
      child: ListTile(
        //  contentPadding: EdgeInsets.fromLTRB(10, 3, 3, 3),
        tileColor: current ? tableDarkColor : bgColor,
        title: txt == 'Notification'
            ? Row(
                children: [
                  Text(
                    txt,
                    style: GoogleFonts.ubuntu(
                      fontSize: 15,
                      color: current ? Colors.black : Colors.white,
                      fontWeight: current ? FontWeight.bold : FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 20),
                  Image.asset(
                    'assets/images/red_bell.png',
                    height: 30,
                    width: 30,
                  )
                ],
              )
            : Text(
                txt,
                style: GoogleFonts.ubuntu(
                  fontSize: 15,
                  color: current ? Colors.black : Colors.white,
                  fontWeight: current ? FontWeight.bold : FontWeight.w400,
                ),
              ),
      ),
    ),
  );
}
