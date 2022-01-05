// previous colors
// const Color colorPrimary = Color(0xffED2939);
// const Color primaryTextColor = Color(0xffffffff);
// const Color bgColor = Color(0xffffffff);
// const Color primaryAccent = Color(0xff000000);
// const Color darkGrey = Color(0xff252525);
// const Color secondaryAccent = Color(0xff828282);
// const Color shadowColor = Color(0xffBFC0BF);
// const Color shadowColorDark = Color(0xff332222);
// const Color textFieldFillColor = Color(0xffE9EAEA);

// const Color grey = Color(0xff828282);
// const Color facebookColor = Color(0xff4051B5);
// const Color greyTextColor = Color(0xff828282);
// const Color white = Color(0xffffffff);

import 'package:flutter/material.dart';
import 'package:tmc/constants/colors.dart';

InputDecoration getInputDecoration(
    String labelText, Color _fillColor, Color _labelColor, prefixIcon, suffixIcon) {
  const double borderWidth = 2;
  const double borderRadius = 12;
  const double gapPadding = 8;
  return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        gapPadding: gapPadding,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        gapPadding: gapPadding,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        gapPadding: gapPadding,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: gapPadding * 2,
        vertical: gapPadding * 2,
      ),
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      labelText: labelText,
      focusColor: bgColor,
      fillColor: _fillColor,
      // hoverColor: bgColor,
      filled: true,
      alignLabelWithHint: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      hintStyle: TextStyle(
        fontSize: 14,
        color: secondaryAccent,
        fontFamily: 'Arvo',
      ),
      labelStyle: TextStyle(
        fontSize: 14,
        color: _labelColor,
        fontFamily: 'Arvo',
      ));
}
