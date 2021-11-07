import 'dart:developer';
import 'dart:ui';

import 'package:admin/models/talluk.dart';
import 'package:admin/responsive.dart';
import 'package:admin/services/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  //late GlobalKey<ScaffoldState> _scaffoldKey;
  late Taluk _selectedTaluk;
  late bool _isUpdating;
  //late String _titleProgres;
  late dynamic _desktopView;
  late String transactionType;
  @override
  void initState() {
    super.initState();
    _talukCodeController = TextEditingController();
    _talukNameController = TextEditingController();
    _isUpdating = false;
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
    Services.getTaluk().then((taluk) {
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
                    Text(talukShow.slNo),
                  ),
                  DataCell(
                    Text(talukShow.talukCode),
                  ),
                  DataCell(
                    Text(talukShow.talukName),
                  ),
                  DataCell(
                    Responsive.isMobile(context)
                        ? IconButton(
                            onPressed: () {
                              transactionType = "UPDATE";
                              _selectedTaluk = talukShow;
                              _showValues(talukShow);
                            },
                            icon: Icon(
                              Icons.edit,
                              color: secondaryColorDark,
                            ),
                          )
                        :
                        //  Responsive.isTablet(context)
                        //     ? ElevatedButton(
                        //         onPressed: () {
                        //           transactionType = "UPDATE";
                        //           _selectedTaluk = talukShow;
                        //           _showValues(talukShow);
                        //         },
                        //         child: Text(
                        //           'EDIT',
                        //           style: TextStyle(
                        //               backgroundColor: primaryColor,
                        //               fontWeight: FontWeight.w400),
                        //         ),
                        //       )
                        //     :
                        ElevatedButton(
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
                        ? IconButton(
                            onPressed: () {
                              //_selectedTaluk = talukShow;
                              _showDeleteDialog(talukShow);
                            },
                            icon: Icon(
                              Icons.delete,
                              color: deleteColor,
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
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
      print('Empty Field');
    } else {
      // _showProgress('Adding Taluk');
      Services.addTaluk(_talukCodeController.text, _talukNameController.text)
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
    Navigator.pop(context, 'Add');
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
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: leftRightPadding,
                child: new TextFormField(
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
                    if (val!.length == 0) {
                      return "Taluk Code cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  //keyboardType: TextInputType.multiline,
                  style: new TextStyle(),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
              ),
              Padding(
                padding: leftRightPadding,
                child: new TextFormField(
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
              ),
            ],
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
                  onPressed: () => _addTaluk(),
                  child: const Text(
                    'Add',
                    style: tableHeadingTextStyle,
                  ),
                )
              : TextButton(
                  style: outlinedButtonStyle,
                  onPressed: () => _updateTaluk(_selectedTaluk),
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
      print('Empty Field');
    } else {
      // _showProgress('Adding Taluk');
      Services.updateTaluk(
              _talukCodeController.text, _talukNameController.text, sl_no_)
          .then((result) {
        debugPrint('Debug report: $result');

        log('HTTP result: $result');
        if ('Success' == result) {
          _getTaluk();
          // _showSnackBar(context, result);
        }
        _clearValues();
        Navigator.pop(context);
      });
    }
  }

  void _deleteTaluk(Taluk selected) {
    Services.deleteTaluk(selected).then((result) {
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
              style: const TextStyle(fontSize: 14),
            ),
            style: negetiveButton,
            onPressed: () => Navigator.pop(context, 'Cancel'),
          ),
          TextButton(
            child: Text(
              "Delete".toUpperCase(),
              style: const TextStyle(fontSize: 14),
            ),
            style: redCircularButton,
            onPressed: () => _deleteTaluk(talukObj),
          ),
        ],
      ),
    );
  }
}
