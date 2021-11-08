import 'dart:js';

import 'package:admin/services/services.dart';
import 'package:admin/screens/home_screen.dart';
import 'screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'utilities/constants.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  int value = 0;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _createTable();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kodagu Gun License Exemption',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        canvasColor: bgColor,
      ),
      home: HomeScreen(),
      //showScreen(dynamic),
    );
  }

  _createTable() {
    //  _showProgress('Creating table');
    Services.createTable().then((result) {
      if ('success' == result) {
        //  _showSnackBar(context, result);
        //_showProgress(widget.title);
      }
    });
  }

  showScreen(param0) {
    switch (value) {
      case 0:
        return HomeScreen();
      case 1:
        return SecondScreen();
      case 2:
        return;
    }
  }
}
