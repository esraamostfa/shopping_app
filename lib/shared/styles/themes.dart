
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shopping_app/shared/styles/colors.dart';

ThemeData darkTheme = ThemeData(
    primarySwatch: defaultColor,
    appBarTheme: AppBarTheme(
        titleSpacing: 21,
        color: HexColor('333739'),
        elevation: 0.0,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 21.0,
            fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.white),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light,
        )),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      unselectedItemColor: Colors.grey,
      backgroundColor: HexColor('333739'),
      elevation: 21,
    ),
    scaffoldBackgroundColor: HexColor('333739'),
    textTheme: TextTheme(bodyText1: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
        color: Colors.white
    )),
  //fontFamily: 'BringHeart'
);

ThemeData lightTheme = ThemeData(
    primarySwatch: defaultColor,
    appBarTheme: AppBarTheme(
        titleSpacing: 21,
        color: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 21.0,
            fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(color: Colors.black),
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        )),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: defaultColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 21,
    ),
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(bodyText1: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
        color: Colors.black
    )),
    //fontFamily: 'BringHeart'
);