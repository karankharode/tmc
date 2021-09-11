// import 'package:easygame/constants/colors.dart';
import 'package:flutter/material.dart';

const Color colorPrimary = Color(0xffC00000);
const Color colorSecondary = Color(0xffFFBF00);
const Color primaryTextColor = Color(0xffffffff);
const Color bgColor = Color(0xff000000);
const Color primaryAccent = Color(0xffffffff);
const Color darkGrey = Color(0xff252525);
const Color secondaryAccent = Color(0xffE9EAEA);
const Color shadowColor = Color(0xff000000);
const Color shadowColorDark = Color(0xff332222);
const Color textFieldFillColor = colorPrimary;

const Color grey = Color(0xff828282);
const Color facebookColor = Color(0xff4051B5);
const Color greyTextColor = Color(0xffE9EAEA);
const Color darkTextColor = Color(0xff000000);
const Color white = Color(0xffffffff);

const Color cursorColor = Color(0xffffffff);

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

InputDecoration getInputDecoration(
    String labelText, Color _fillColor, Color _labelColor, prefixIcon, suffixIcon) {
  const double borderWidth = 2;
  const double borderRadius = 12;
  const double gapPadding = 8;
  return InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: textFieldFillColor,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        gapPadding: gapPadding,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: colorPrimary,
          width: borderWidth,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        gapPadding: gapPadding,
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(
          color: colorPrimary,
          width: borderWidth,
        ),
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
      hoverColor: bgColor,
      filled: true,
      hintStyle: TextStyle(
        fontSize: 14,
        color: secondaryAccent,
        fontFamily: 'GothamMedium',
      ),
      labelStyle: TextStyle(
        fontSize: 14,
        color: _labelColor,
        fontFamily: 'GothamMedium',
      ));
}
