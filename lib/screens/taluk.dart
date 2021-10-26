import 'package:admin/widget/NavigationDrawer.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class Taluk extends StatelessWidget {
  const Taluk({Key? key}) : super(key: key);

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
            child: Text('Taluk Screen'),
          ),
        ),
      ),
    );
  }
}
