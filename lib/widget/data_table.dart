import 'dart:developer';

import 'package:admin/models/talluk.dart';
import 'package:admin/services/services.dart';
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
  late TextEditingController _talukCodeController;
  late TextEditingController _talukNameController;
  late Taluk _selectedTaluk;
  late bool _isUpdating;
  late String _titleProgres;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _taluk = [];
    _isUpdating = false;
    _titleProgres = widget.title;
    _scaffoldKey = GlobalKey();
    _talukCodeController = TextEditingController();
    _talukNameController = TextEditingController();
    _getTaluk();
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
    //currentState.showSnackBar(SnackBar(content: Text(message),),);
  }

  _createTable() {
    _showProgress('Creating table');
    Services.createTable().then((result) {
      if ('success' == result) {
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
  }

  _clearValues() {
    _talukCodeController.text = "";
    _talukNameController.text = "";
  }

  _addTaluk() {
    if (_talukCodeController.text.isEmpty ||
        _talukNameController.text.isEmpty) {
      print('Empty Field');
    } else {
      _showProgress('Adding Taluk');
      Services.addTaluk(_talukCodeController.text, _talukNameController.text)
          .then((result) {
        debugPrint('Debug report: $result');

        log('HTTP result: $result');
        if ('Success' == result) {
          _getTaluk();
          _showSnackBar(context, result);
        }
        _clearValues();
      });
    }
  }

  _getTaluk() {
    _showProgress("Loading Taluk names");
    Services.getTaluk().then((taluk) {
      setState(() {
        _taluk = taluk;
      });
      _showProgress(widget.title);
    });
  }

  SingleChildScrollView _dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('Taluk ID'),
            ),
            DataColumn(
              label: Text('Taluk Name'),
            )
          ],
          rows: _taluk
              .map(
                (talukShow) => DataRow(cells: [
                  DataCell(
                    Text(talukShow.talukCode),
                  ),
                  DataCell(
                    Text(talukShow.talukName),
                  )
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgres),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _createTable();
              }),
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                _getTaluk();
              })
        ],
      ),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: _talukCodeController,
              decoration: InputDecoration.collapsed(hintText: 'Taluk ID'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: _talukNameController,
              decoration: InputDecoration.collapsed(hintText: 'Taluk Name'),
            ),
          ),

//here to add update n cancel button _isUpdateing = true
          Expanded(child: _dataBody()),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTaluk();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
