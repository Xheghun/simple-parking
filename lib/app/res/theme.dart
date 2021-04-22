import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_parking/app/res/colors.dart';

class AppTheme {
  static ThemeData defaultTheme() {
    return ThemeData(
      primaryColor: colorPrimary,
      primaryColorLight: colorPrimaryLight,
      fontFamily: GoogleFonts.poppins().fontFamily,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: colorPrimary,
          unselectedItemColor: colorPrimaryLight,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.shifting,
          selectedLabelStyle:
              GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
          unselectedLabelStyle:
              GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w400)),
      textTheme: TextTheme(
        headline2:
            GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
        bodyText1:
            GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
      ),
    );
  }
}
