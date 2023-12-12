import 'package:flutter/material.dart';
import 'package:flutter_flashcards/configs/constants.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: kRed,
  scaffoldBackgroundColor: kYellow,

  // Text Theme
  textTheme: TextTheme(
    bodyText2: GoogleFonts.notoSans(
      fontSize: 15,
      color: Colors.black, // Changed to black for better visibility
    ),
    headline1: GoogleFonts.notoSans(
      fontSize: 58,
      fontWeight: FontWeight.bold,
      color: Colors.black, // Changed to black for better visibility
    ),
  ),

  // App Bar Theme
  appBarTheme: AppBarTheme(
    elevation: 0,
    centerTitle: true,
    color: kRed,
    titleTextStyle: GoogleFonts.notoSans(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white, // White color for contrast against red AppBar
    ),
  ),

  // Dialog Theme
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kCircularBorderRadius),
    ),
    backgroundColor: kRed,
    contentTextStyle: GoogleFonts.notoSans(
      fontSize: 20,
      color: Colors.white, // White color for contrast
    ),
    titleTextStyle: GoogleFonts.notoSans(
      fontSize: 20,
      color: Colors.white, // White color for contrast
    ),
  ),

  // Elevated Button Theme
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: kYellow,
      onPrimary: Colors.black, // Text color on buttons
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kCircularBorderRadius),
        side: const BorderSide(color: Colors.white),
      ),
      textStyle: GoogleFonts.notoSans(
        fontSize: 12,
      ),
    ),
  ),

  // Progress Indicator Theme
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: kRed,
    linearTrackColor: Colors.grey,
  ),

  // Switch Theme
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all<Color>(kRed),
    trackColor: MaterialStateProperty.all<Color>(Colors.grey), // Added for better visibility
  ),

  // ListTile Theme
  listTileTheme: const ListTileThemeData(
    textColor: Colors.black, // Changed to black for better visibility
    iconColor: Colors.black, // Changed to black for better visibility
  ),
);
