import 'package:admin/constants.dart';
import 'package:admin/widget/NavigationDrawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
            child: Text('homeScreen'),
          ),
        ),
      ),
    );
  }
}
