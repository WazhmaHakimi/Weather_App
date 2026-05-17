import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const apiKey = '7c0f760c846e6cbcdc56299315d94739';

const kLightColor = Colors.white;

const kMidLightColor = Colors.white60;

const kDarkColor = Colors.white24;

var kLocationTextStyle = GoogleFonts.monda(fontSize: 20, color: kMidLightColor);

var kTempTextStyle = GoogleFonts.daysOne(fontSize: 80);

var kDetailsTextStyle = GoogleFonts.monda(
  fontSize: 20,
  color: kMidLightColor,
  fontWeight: FontWeight.bold,
);

var kDetailsTitleTextStyle = GoogleFonts.monda(fontSize: 16, color: kDarkColor);

var kDetailsSuffixStyle = GoogleFonts.monda(
  fontSize: 12,
  color: kMidLightColor,
);

const kTextFieldTextStyle = TextStyle(fontSize: 16, color: kMidLightColor);

const kOverlayColor = Colors.white10;

const kTextFieldDecoration = InputDecoration(
  fillColor: kOverlayColor,
  filled: true,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide.none,
  ),
  hintText: 'Enter City Name',
  hintStyle: kTextFieldTextStyle,
  prefixIcon: Icon(Icons.search),
);
