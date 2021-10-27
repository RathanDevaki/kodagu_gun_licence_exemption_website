import 'dart:js';

import 'package:admin/services/services.dart';
import 'package:admin/widget/home_screen.dart';
import './widget/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  int value = 0;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _createTable();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kodagu Gun Licence Exemption',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
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
