import 'package:admin/models/hobli.dart';
import 'package:admin/widget/hobli_table_widget.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:admin/utilities/constants.dart';
import 'package:admin/models/talluk.dart';
import 'package:admin/utilities/responsive.dart';
import 'package:admin/widget/taluk_table_widget.dart';
import 'package:admin/services/taluk_service.dart';
import 'package:admin/widget/NavigationDrawer.dart';
import 'package:admin/widget/appbar.dart';

import 'package:flutter/foundation.dart';

class HobliScreen extends StatefulWidget {
  const HobliScreen({Key? key}) : super(key: key);
  final String title = 'Data from Mysql';
  @override
  _HobliScreenState createState() => _HobliScreenState();
}

class _HobliScreenState extends State<HobliScreen> {
  late Hobli hobliData;
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
          child: HobliTable(),
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
                        'Hobli Details'.toUpperCase(),
                        style: headingTextStyle,
                      ),
                    ),
                    Expanded(
                      child: _databody(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
