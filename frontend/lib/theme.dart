import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData theme(){
return ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "Muli",

        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black), 
          // ignore: prefer_const_constructors
          toolbarTextStyle: TextTheme(
            titleLarge: TextStyle(color: Color(0XFF8B8B8B), fontSize:18),
          // ignore: prefer_const_constructors
          ).titleLarge, titleTextStyle: TextTheme(
            titleLarge: TextStyle(color: Color(0XFF8B8B8B), fontSize:18),
          ).titleLarge,
        ),

        
        textTheme: TextTheme(
          bodyText1: TextStyle(color: kTextColor),
          bodyText2: TextStyle(color: kTextColor),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.blue,
      );
}
InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(28),
    borderSide: BorderSide(color: kTextColor),
    gapPadding: 10,
  );
  return InputDecorationTheme(
    // If  you are using latest version of flutter then lable text and hint text shown like this
    // if you r using flutter less then 1.20.* then maybe this is not working properly
    // if we are define our floatingLabelBehavior in our theme then it's not applayed
    floatingLabelBehavior: FloatingLabelBehavior.always,
    contentPadding: EdgeInsets.symmetric(horizontal: 42, vertical: 20),
    enabledBorder: outlineInputBorder,
    focusedBorder: outlineInputBorder,
    border: outlineInputBorder,
  );
}