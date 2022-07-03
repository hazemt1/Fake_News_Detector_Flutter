import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

enum AppTheme{
  lightTheme,
  darkTheme
}

class MyThemeData {
  static final lightTheme = ThemeData(

    textTheme: TextTheme(
      headline1: GoogleFonts.lobster(
        fontSize: 30,
        color: Colors.black,
        // fontWeight: FontWeight.bold
      ),
      headline2: GoogleFonts.lobster(
        fontSize: 40,
        color: Colors.black,
        // fontWeight: FontWeight.bold
      ),
      headline4: GoogleFonts.cookie(
        fontSize: 42,
        color: HexColor('#000000'),
        // fontWeight: FontWeight.bold,
      ),
      headline6: GoogleFonts.merriweather(
        fontSize: 18,
        color: HexColor('#000000'),
        // fontWeight: FontWeight.bold,
      ),
      headline3: GoogleFonts.merriweather(
        fontSize: 24,
        color: HexColor('#000000'),
        // fontWeight: FontWeight.bold,
      ),
      bodyText1: GoogleFonts.merriweather(
        fontSize: 16,
        color: HexColor('#ffffff'),
        // fontWeight: FontWeight.bold,
      ),
      bodyText2: GoogleFonts.merriweather(
        fontSize: 16,
        color: HexColor('#000000'),
        // fontWeight: FontWeight.bold,
      ),
      subtitle1: GoogleFonts.merriweather(
        fontSize: 16,
        color: HexColor('#65737e'),
        // fontWeight: FontWeight.bold,
      ),

    ),

    iconTheme: IconThemeData(color: HexColor('#000000')),
    primaryColor: HexColor('#ffffff'),
    shadowColor: HexColor('#c8d8e4'),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: HexColor('#55C57A'),
      secondary: HexColor('#f2f2f2'),
      onPrimary: HexColor('#FFFFFF'),
    ),
  );
  static final darkTheme = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: GoogleFonts.barlow().fontFamily,
    textTheme: TextTheme(
        headline1: GoogleFonts.lobster(
          fontSize: 30,
          color: Colors.white,
          // fontWeight: FontWeight.bold
        ),
      headline2: GoogleFonts.lobster(
        fontSize: 40,
        color: Colors.white,
        // fontWeight: FontWeight.bold
      ),
      headline4: GoogleFonts.cookie(
        fontSize: 42,
        color: HexColor('#ffffff'),
        // fontWeight: FontWeight.bold,
      ),
        headline6: GoogleFonts.merriweather(
          fontSize: 18,
          color: HexColor('#ffffff'),
          // fontWeight: FontWeight.bold,
        ),
      headline3: GoogleFonts.merriweather(
        fontSize: 24,
        color: HexColor('#ffffff'),
        // fontWeight: FontWeight.bold,
      ),
      bodyText1: GoogleFonts.merriweather(
        fontSize: 16,
        color: HexColor('#ffffff'),
        // fontWeight: FontWeight.bold,
      ),
      bodyText2: GoogleFonts.merriweather(
        fontSize: 16,
        color: HexColor('#ffffff'),
        // fontWeight: FontWeight.bold,
      ),
      subtitle1: GoogleFonts.merriweather(
        fontSize: 16,
        color: HexColor('#52ab98'),
        // fontWeight: FontWeight.bold,
      ),
    ),
    bottomSheetTheme:
        const BottomSheetThemeData(backgroundColor: Colors.white12),
    iconTheme: IconThemeData(color: HexColor('#ffffff')),
    primaryColor: HexColor('#252836'),
    shadowColor: HexColor('#393C49'),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: HexColor('#52ab98'),
        secondary: HexColor('#EA7C69'),
        onPrimary: HexColor('#1F1D2B'),
    ),
  );
}
