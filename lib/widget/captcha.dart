import 'dart:math';
import 'package:hb_check_code/hb_check_code.dart';
import 'package:flutter/material.dart';

class Captcha extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HBCheckCode Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CodeTestPage(),
    );
  }
}

class CodeTestPage extends StatefulWidget {
  @override
  _CodeTestPageState createState() => _CodeTestPageState();
}

class _CodeTestPageState extends State<CodeTestPage> {
  @override
  Widget build(BuildContext context) {
    String code = "";
    for (var i = 0; i < 6; i++) {
      code = code + Random().nextInt(9).toString();
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("TestTest"),
        ),
        body: Container(
            alignment: Alignment.center,
            child: HBCheckCode(
              code: code,
            )));
  }
}