import 'package:admin/widget/appbar.dart';
import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import '../widget/NavigationDrawer.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
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
