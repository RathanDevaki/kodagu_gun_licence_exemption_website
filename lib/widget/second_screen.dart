import 'package:flutter/material.dart';

import '../constants.dart';
import 'NavigationDrawer.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text('Kodagu'),
      ),
      drawer: NavigationDrawer(),
      body: SafeArea(
        child: Center(
          child: Container(
            child: Text('Second Screen'),
          ),
        ),
      ),
    );
  }
}
