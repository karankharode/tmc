import 'package:flutter/material.dart';
import 'package:tmc/constants/colors.dart';

// login
final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  onPrimary: Colors.black87,
  primary: darkRed_primary,
  elevation: 2,
  shadowColor: grey,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
  shape: const RoundedRectangleBorder(
    side: BorderSide(
      color: white,
    ),
    borderRadius: BorderRadius.all(Radius.circular(4)),
  ),
);
