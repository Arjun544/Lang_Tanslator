import 'package:flutter/material.dart';

class MyThemes {
  static final ThemeData light = ThemeData(
    backgroundColor: Colors.white,
    popupMenuTheme: PopupMenuThemeData(color: Colors.white),
    primaryColor: Color(0xFF2978B5),
    buttonColor: Colors.black,
    // appBarTheme: AppBarTheme(
    //   textTheme: TextTheme(
    //     headline1: TextStyle(
    //       fontSize: 30,
    //       color: CustomColors.darkColor,
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    //   iconTheme: IconThemeData(
    //     color: CustomColors.blackColor,
    //   ),
    // ),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   backgroundColor: Colors.white,
    //   elevation: 15,
    //   unselectedItemColor: Colors.grey,
    //   selectedItemColor: CustomColors.blackColor,
    // ),
    // floatingActionButtonTheme: FloatingActionButtonThemeData(
    //   foregroundColor: CustomColors.blackColor,
    //   backgroundColor: Colors.white70,
    // ),
    accentColor: Color(0xFFA2DBFA),
    textTheme: TextTheme(
      headline2: TextStyle(
        color: Colors.black,
      ),
      headline3: TextStyle(color: Colors.grey),
      headline4: TextStyle(color: Colors.green),
    ),
    cardColor: Colors.white, // Profile & Fav Screens card
    cardTheme: CardTheme(
      color: Colors.black.withOpacity(0.2),
    ), // Articles Screen card
  );

  static final ThemeData dark = ThemeData(
    backgroundColor: Color(0xFF171717),
    popupMenuTheme: PopupMenuThemeData(color: Colors.black),
    buttonColor: Colors.white,
    cardTheme: CardTheme(
      color: Colors.white.withOpacity(0.2),
    ),
    accentColor: Color(0xFF39A2DB),
    primaryColor: Color(0xFF3C415C),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   elevation: 15,
    //   backgroundColor: CustomColors.bottomBarColor,
    //   unselectedItemColor: Colors.white,
    //   selectedItemColor: CustomColors.blackColor,
    // ),
    // appBarTheme: AppBarTheme(
    //   textTheme: TextTheme(
    //     headline1: TextStyle(
    //       fontSize: 30,
    //       color: Colors.white,
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    //   iconTheme: IconThemeData(color: Colors.white),
    // ),
    // floatingActionButtonTheme: FloatingActionButtonThemeData(
    //   foregroundColor: CustomColors.bottomBarColor,
    //   backgroundColor: CustomColors.greyColor,
    // ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
      ),
      headline2: TextStyle(
        color: Colors.white,
      ),
      headline3: TextStyle(color: Colors.white),
      headline4: TextStyle(color: Colors.white),
    ),
    cardColor: Color(0xFF3C415C), // Profile & Fav screens card
    // cardTheme: CardTheme(
    //   color:
    //       CustomColors.bottomBarColor.withOpacity(0.9), // Articles Screen card
    // ),
  );
}
