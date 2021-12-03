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
      drawer: Responsive.isDesktop(context) ? null : NavigationDrawer(),
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
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: const Offset(
                          1.5,
                          1.0,
                        ),
                        blurRadius: 24.0,
                        spreadRadius: 4.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: Image.asset("assets/images/logo.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
