import 'dart:developer';

import 'package:admin/models/talluk.dart';
import 'package:admin/utilities/responsive.dart';
import 'package:admin/services/taluk_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../utilities/constants.dart';

class TalukTable extends StatefulWidget {
  const TalukTable({Key? key}) : super(key: key);

  @override
  State<TalukTable> createState() => _TalukTableState();
}

class _TalukTableState extends State<TalukTable> {
  late List<Taluk> taluk_ = [];

  late TextEditingController _talukCodeController;
  late TextEditingController _talukNameController;
  late Taluk _selectedTaluk;
  final _formKey = GlobalKey<FormState>();
  late String transactionType;
  int i=0;
  @override
  void initState() {
    super.initState();
    _talukCodeController = TextEditingController();
    _talukNameController = TextEditingController();
    transactionType = "";

    //_scaffoldKey = GlobalKey();
    _getTaluk();
  }

  _showValues(Taluk taluk_ref) {
    showAddTalukDialog(transactionType);
    _talukCodeController.text = taluk_ref.talukCode;
    _talukNameController.text = taluk_ref.talukName;
  }

  _getTaluk() {
    // _showProgress("Loading Taluk names");
    TalukServices.getTaluk().then((taluk) {
      setState(() {
        taluk_ = taluk;
        return;
      });
      // _showProgress(widget.title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: tableBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: DataTable(
          columnSpacing: MediaQuery.of(context).size.width * 0.02,
          sortColumnIndex: 1,
          sortAscending: true,
          columns: [
            DataColumn(
              label: Text(
                'SL. NO',
                style: tableHeadingTextStyle,
              ),
            ),
            DataColumn(
              label: Text(
                'Taluk Code',
                style: tableHeadingTextStyle,
              ),
            ),
            DataColumn(
              label: Text(
                'Taluk Name',
                style: tableHeadingTextStyle,
              ),
            ),
            DataColumn(
              label: Visibility(
                visible: false,
                child: Text('Update'),
              ),
            ),
            DataColumn(
              label: Expanded(
                //flex: 8,
                child: Responsive.isMobile(context)
                    ? ElevatedButton(
                        style: outlinedButtonStyle,
                        child: Icon(Icons.add),
                        onPressed: () {
                          transactionType = "ADD";
                          showAddTalukDialog(transactionType);
                        },
                      )
                    : TextButton(
                        child: Text(
                          "Add".toUpperCase(),
                          style: tableHeadingTextStyle,
                        ),
                        style: outlinedButtonStyle,
                        onPressed: () {
                          transactionType = "ADD";
                          showAddTalukDialog(transactionType);
                        }),
              ),
            ),
          ],
          rows: taluk_
              .map(
                (talukShow) => DataRow(cells: [
                  DataCell(
                    Text((++i).toString()),
                  ),
                  DataCell(
                    Text(talukShow.talukCode),
                  ),
                  DataCell(
                    Text(talukShow.talukName),
                  ),
                  DataCell(
                    Responsive.isMobile(context)
                        ? Center(
                            child: IconButton(
                              onPressed: () {
                                transactionType = "UPDATE";
                                _selectedTaluk = talukShow;
                                _showValues(talukShow);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: secondaryColorDark,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              transactionType = "UPDATE";
                              _selectedTaluk = talukShow;
                              _showValues(talukShow);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: secondaryColorDark,
                              elevation: 16.0,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              // textStyle: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            child: Text(
                              'EDIT',
                            ),
                          ),
                  ),
                  DataCell(
                    Responsive.isMobile(context)
                        ? Center(
                            child: IconButton(
                              onPressed: () {
                                //_selectedTaluk = talukShow;
                                i=0;
                                _showDeleteDialog(talukShow);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: deleteColor,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              i=0;
                              _showDeleteDialog(talukShow);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: deleteColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              // textStyle: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            child: Text(
                              'Delete'.toUpperCase(),
                            ),
                          ),
                  ),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  _clearValues() {
    _talukCodeController.text = "";
    _talukNameController.text = "";
  }

  _addTaluk() {
    if (_talukCodeController.text.isEmpty ||
        _talukNameController.text.isEmpty) {
      //print('Empty Field');
    } else {
      // _showProgress('Adding Taluk');
      TalukServices.addTaluk(
              _talukCodeController.text, _talukNameController.text)
          .then(
        (result) {
          debugPrint('Debug report: $result');

          log('HTTP result: $result');
          if ('Success' == result) {
            _getTaluk();
            // _showSnackBar(context, result);
          }
          _clearValues();
        },
      );
    }
    //Navigator.pop(context, 'Add');
  }

  void showAddTalukDialog(String transactionType) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: transactionType == 'ADD'
            ? const Text(
                'Add New Taluk',
                style: tableHeadingTextStyle,
              )
            : const Text(
                'Update Taluk',
                style: tableHeadingTextStyle,
              ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.24,
          height: 180,
          child: Scaffold(
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new TextFormField(
                      controller: _talukCodeController,

                      decoration: new InputDecoration(
                        labelText: "Taluk Code ",
                        labelStyle: TextStyle(fontSize: 14),
                        fillColor: Colors.amber,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(16.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Taluk Code cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      //keyboardType: TextInputType.multiline,
                      style: new TextStyle(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                    new TextFormField(
                      controller: _talukNameController,
                      decoration: textFormDecoration,
                      validator: (val) {
                        if (val!.length == 0) {
                          return "Taluk Name cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      //keyboardType: TextInputType.multiline,
                      style: new TextStyle(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: negetiveButton,
            onPressed: () {
              Navigator.pop(context, 'Cancel');
              _clearValues();
            },
            child: const Text(
              'Cancel',
              style: tableHeadingTextStyle,
            ),
          ),
          transactionType == "ADD"
              ? TextButton(
                  style: outlinedButtonStyle,
                  onPressed: () {
                    i=0;
                    if (_formKey.currentState!.validate()) {
                      _addTaluk();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("New Taluk Added Succesfully"),
                        ),
                      );
                      Navigator.of(context).pop();
                    } else {
                      log("Error Adding");
                      return;
                    }
                  },
                  child: const Text(
                    'Add',
                    style: tableHeadingTextStyle,
                  ),
                )
              : TextButton(
                  style: outlinedButtonStyle,
                  onPressed: () {
                    i=0;
                    if (_formKey.currentState!.validate()) {
                      _updateTaluk(_selectedTaluk);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Taluk Updated Succesfully"),
                        ),
                      );
                      Navigator.of(context).pop();
                    } else {
                      log("Error Updating");
                      return;
                    }
                  },
                  child: const Text(
                    'Update',
                    style: tableHeadingTextStyle,
                  ),
                ),
        ],
      ),
    );
  }

  _updateTaluk(Taluk selected) {
    String sl_no_ = selected.slNo;
    if (_talukCodeController.text.isEmpty ||
        _talukNameController.text.isEmpty) {
      // print('Empty Field');
    } else {
      // _showProgress('Adding Taluk');
      TalukServices.updateTaluk(
              _talukCodeController.text, _talukNameController.text, sl_no_)
          .then((result) {
        debugPrint('Debug report: $result');

        log('HTTP result: $result');
        if ('Success' == result) {
          _getTaluk();
          // _showSnackBar(context, result);
        }
        _clearValues();
        //  Navigator.pop(context);
      });
    }
  }

  void _deleteTaluk(Taluk selected) {
    TalukServices.deleteTaluk(selected).then((result) {
      debugPrint('Debug report: $result');

      log('HTTP result: $result');
      if ('Success' == result) {
        Fluttertoast.showToast(
            msg: "Deleted",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        _getTaluk();
        // _showSnackBar(context, result);
      }

      Navigator.pop(context);
    });
  }

  void _showDeleteDialog(Taluk talukObj) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
            "Are you sure want to delete the Taluk ${talukObj.talukName} ?"),
        actions: <Widget>[
          TextButton(
            child: Text(
              "Cancel".toUpperCase(),
              style: tableHeadingTextStyle,
            ),
            style: negetiveButton,
            onPressed: () => Navigator.pop(context, 'Cancel'),
          ),
          TextButton(
            child: Text(
              "Delete".toUpperCase(),
              style: tableHeadingTextStyle,
            ),
            style: redCircularButton,
            onPressed: () => _deleteTaluk(talukObj),
          ),
        ],
      ),
    );
  }
}
