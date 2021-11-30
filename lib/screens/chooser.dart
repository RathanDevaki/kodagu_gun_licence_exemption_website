import 'package:admin/screens/application_form.dart';
import 'package:admin/screens/home_screen.dart';
import 'package:admin/utilities/constants.dart';
import 'package:admin/widget/appbar.dart';
import 'package:flutter/material.dart';

class Chooser extends StatelessWidget {
  const Chooser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: SafeArea(
        child: Container(
          height: 200,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                child: Text(
                  "Admin".toUpperCase(),
                  style: tableHeadingTextStyle,
                ),
                style: outlinedButtonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              ),
              TextButton(
                child: Text(
                  "User".toUpperCase(),
                  style: tableHeadingTextStyle,
                ),
                style: outlinedButtonStyle,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApplicationForm(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
