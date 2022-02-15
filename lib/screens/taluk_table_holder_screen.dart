import 'dart:developer';

import 'package:admin/utilities/constants.dart';
import 'package:admin/models/talluk.dart';
import 'package:admin/utilities/responsive.dart';
import 'package:admin/widget/footer.dart';
import 'package:admin/widget/taluk_table_widget.dart';
import 'package:admin/services/taluk_service.dart';
import 'package:admin/widget/NavigationDrawer.dart';
import 'package:admin/widget/appbar.dart';
import 'package:flutter/material.dart';

import 'package:flutter/foundation.dart';

class DataTableDB extends StatefulWidget {
  DataTableDB() : super();
  final String title = 'Data from Mysql';
  @override
  DataTableDBState createState() => DataTableDBState();
}

class DataTableDBState extends State<DataTableDB> {
  late Taluk talukShow;
  late List<Taluk> _taluk;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  late String _titleProgres;

  @override
  void initState() {
    super.initState();

    _taluk = [];
    // _isUpdating = false;
    // _titleProgres = widget.title;
    _scaffoldKey = GlobalKey();
  }

  _showProgress(String message) {
    setState(() {
      _titleProgres = message;
    });
  }

  _showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added Succesfully'),
      ),
    );
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: TalukTable(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Footer1(),
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
//here to add update n cancel button _isUpdateing = true

                    Padding(
                      padding: defaultPadding,
                      child: Text(
                        'Taluk details'.toUpperCase(),
                        style: headingTextStyle,
                      ),
                    ),

                    Expanded(
                      child: _dataBody(),
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
