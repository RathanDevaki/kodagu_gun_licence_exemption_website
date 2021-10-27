import 'dart:developer';

import 'package:admin/models/talluk.dart';
import 'package:admin/services/services.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class TalukTable extends StatefulWidget {
  const TalukTable({Key? key}) : super(key: key);

  @override
  State<TalukTable> createState() => _TalukTableState();
}

class _TalukTableState extends State<TalukTable> {
  late List<Taluk> taluk_ = [];

  late TextEditingController _talukCodeController;
  late TextEditingController _talukNameController;
  @override
  void initState() {
    super.initState();
    _talukCodeController = TextEditingController();
    _talukNameController = TextEditingController();
  }

  _getTaluk() {
    // _showProgress("Loading Taluk names");
    Services.getTaluk().then((taluk) {
      setState(() {
        taluk_ = taluk;
      });
      // _showProgress(widget.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    _getTaluk();

    return DataTable(
      columns: [
        DataColumn(
          label: Text(
            'SL. NO',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Taluk Code',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Taluk Name',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Visibility(
            visible: false,
            child: Text('Update'),
          ),
        ),
        // DataColumn(
        //   label: Visibility(
        //     visible: false,
        //     child: Text('Delete'),
        //   ),
        // ),
        DataColumn(
          label: Visibility(
            visible: true,
            child: ElevatedButton(
              child: Icon(Icons.add),
              onPressed: () => showAddTalukDialog(),
            ),
          ),
        ),
      ],
      rows: taluk_
          .map(
            (talukShow) => DataRow(cells: [
              DataCell(
                Text(talukShow.slNo),
              ),
              DataCell(
                Text(talukShow.talukCode),
              ),
              DataCell(
                Text(talukShow.talukName),
              ),
              DataCell(
                Icon(
                  Icons.edit,
                  color: primaryColor,
                ),
              ),
              DataCell(
                Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ]),
          )
          .toList(),
    );
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
      // _showProgress('Adding Taluk');
      Services.addTaluk(_talukCodeController.text, _talukNameController.text)
          .then((result) {
        debugPrint('Debug report: $result');

        log('HTTP result: $result');
        if ('Success' == result) {
          _getTaluk();
          // _showSnackBar(context, result);
        }
        _clearValues();
      });
    }
    Navigator.pop(context, 'Add');
  }

  void showAddTalukDialog() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Add New Taluk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: defaultPadding,
              child: TextField(
                controller: _talukCodeController,
                decoration: InputDecoration.collapsed(hintText: 'Taluk Code'),
              ),
            ),
            Padding(
              padding: defaultPadding,
              child: TextField(
                controller: _talukNameController,
                decoration: InputDecoration.collapsed(hintText: 'Taluk Name'),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => _addTaluk(),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
