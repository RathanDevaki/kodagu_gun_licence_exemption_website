import 'package:admin/models/station.dart';
import 'package:admin/utilities/constants.dart';
import 'package:admin/utilities/responsive.dart';
import 'package:admin/widget/NavigationDrawer.dart';
import 'package:admin/widget/appbar.dart';
import 'package:admin/widget/hobli_table_widget.dart';
import 'package:admin/widget/police_station_widget.dart';
import 'package:flutter/material.dart';

class PoliceStationScreen extends StatefulWidget {
  const PoliceStationScreen({Key? key}) : super(key: key);

  @override
  _PoliceStationScreenState createState() => _PoliceStationScreenState();
}

class _PoliceStationScreenState extends State<PoliceStationScreen> {
  late Station hobliData;
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
          child: PoliceStationTable(),
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
                        'Police Stations Details'.toUpperCase(),
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
