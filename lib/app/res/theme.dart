import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_parking/app/res/colors.dart';

class AppTheme {
  static ThemeData defaultTheme() {
    return ThemeData(
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: colorPrimary),
      primaryColor: colorPrimary,
      scaffoldBackgroundColor: Colors.white,
      primaryColorLight: colorPrimaryLight,
      fontFamily: GoogleFonts.poppins().fontFamily,
      appBarTheme: AppBarTheme(elevation: 0, backgroundColor: Colors.white),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: colorPrimary,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.blueGrey,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.shifting,
          selectedLabelStyle:
              GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400)),
      textTheme: TextTheme(
        headline1: GoogleFonts.poppins(
            fontSize: 20, fontWeight: FontWeight.w600, color: colorPrimary),
        headline2:
            GoogleFonts.poppins(fontSize: 18, color: colorPrimary, fontWeight: FontWeight.w500),
        bodyText1:
            GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
        subtitle2: GoogleFonts.poppins(
            fontSize: 13, color: Colors.grey, fontWeight: FontWeight.w500),
      ),
    );
  }
}
