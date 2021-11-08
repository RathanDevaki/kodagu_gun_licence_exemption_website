import 'package:admin/utilities/constants.dart';
import 'package:admin/utilities/responsive.dart';
import 'package:admin/widget/NavigationDrawer.dart';
import 'package:admin/widget/appbar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      drawer: NavigationDrawer(),
      body: SafeArea(
        child: Row(
          children: [
            Responsive.isDesktop(context)
                ? Expanded(
                    child: NavigationDrawer(),
                  )
                : Container(),
            Expanded(
              flex: 5,
              child: Container(color: Colors.amber.shade400),
            ),
          ],
        ),
      ),
    );
  }
}
