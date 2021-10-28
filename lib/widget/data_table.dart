import 'dart:developer';

import 'package:admin/constants.dart';
import 'package:admin/models/talluk.dart';
import 'package:admin/screens/taluk_data_table.dart';
import 'package:admin/services/services.dart';
import 'package:admin/widget/NavigationDrawer.dart';
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
      key: _scaffoldKey,
      drawer: NavigationDrawer(),
      appBar: AppBar(
        backgroundColor: secondaryColor,
        title: Text('Kodagu'),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
//here to add update n cancel button _isUpdateing = true
              Expanded(child: _dataBody()),
            ],
          ),
        ),
      ),
    );
  }
}
