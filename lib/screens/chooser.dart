import 'package:admin/models/admin_login.dart';
import 'package:admin/screens/application_form.dart';
import 'package:admin/screens/home_screen.dart';
import 'package:admin/utilities/constants.dart';
import 'package:admin/widget/admin_login_page.dart';
import 'package:admin/widget/appbar.dart';

import 'package:flutter/material.dart';

class Chooser extends StatelessWidget {
  const Chooser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(),
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                color: tableBackground),
            width: 460,
            height: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,

              //mainAxisSize: MainAxisSize.min,.
              children: <Widget>[
                Text(
                  'Gun License Exemption Certificate Kodagu ',
                  style: headingTextStyle,
                ),
                Divider(
                  color: secondaryColorDark,
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Text(
                                'Master',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPage()));
                    },
                    color: Theme.of(context).accentColor,
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 24.0),
                              child: Text(
                                'Users',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 16.0),
                //   child: TextButton(
                //     child: Text(
                //       "Admin".toUpperCase(),
                //       style: tableHeadingTextStyle,
                //     ),
                //     style: outlinedButtonStyle,
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => HomeScreen(),
                //         ),
                //       );
                //     },
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 16.0),
                //   child: TextButton(
                //     child: Text(
                //       "User".toUpperCase(),
                //       style: tableHeadingTextStyle,
                //     ),
                //     style: outlinedButtonStyle,
                //     onPressed: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => ApplicationForm(),
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
