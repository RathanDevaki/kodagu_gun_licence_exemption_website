import 'package:admin/models/va_circle.dart';
import 'package:admin/models/village.dart';
import 'package:admin/widget/va_circle_table_widget.dart';
import 'package:admin/widget/village_table_widget.dart';
import 'package:flutter/material.dart';

import 'package:admin/utilities/constants.dart';

import 'package:admin/utilities/responsive.dart';

import 'package:admin/widget/NavigationDrawer.dart';
import 'package:admin/widget/appbar.dart';

import 'package:flutter/foundation.dart';

class VillageScreen extends StatefulWidget {
  const VillageScreen({Key? key}) : super(key: key);
  final String title = 'Data from Mysql';
  @override
  _VillageScreenState createState() => _VillageScreenState();
}

class _VillageScreenState extends State<VillageScreen> {
 // late Village villageDate;
  late GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  void initState() {
    // TODO: implement initState
    _scaffoldKey = GlobalKey();
    super.initState();
  }

  SingleChildScrollView _databody() {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: VillageTable(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Responsive.isDesktop(context) ? null : NavigationDrawer(),
      appBar: CommonAppBar(),
      body: Container(
        child: Row(
          children: <Widget>[
            Responsive.isDesktop(context)
                ? Expanded(
              child: NavigationDrawer(),
            )
                : Container(),
            Expanded(
              flex: 5,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: defaultPadding,
                      child: Text(
                        'Village Details'.toUpperCase(),
                        style: headingTextStyle,
                      ),
                    ),
                    Expanded(
                      child: _databody(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
