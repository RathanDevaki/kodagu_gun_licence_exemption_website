import 'dart:developer';

import 'package:admin/models/hobli.dart';
import 'package:admin/models/talluk.dart';
import 'package:admin/services/hobli_service.dart';
import 'package:admin/utilities/constants.dart';
import 'package:admin/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HobliTable extends StatefulWidget {
  const HobliTable({Key? key}) : super(key: key);

  @override
  _HobliTableState createState() => _HobliTableState();
}

class _HobliTableState extends State<HobliTable> {
  static const double kMinInteractiveDimension = 48.0;
  late List<Hobli> hobli_ = [];
  late List<Taluk> taluk_ = [];
  late String transactionType;
  late TextEditingController _hobliNameController;
  late TextEditingController _hobliCodeController;
  final _formKey = GlobalKey<FormState>();
  late Hobli _selectedHobli;
  // late List taluk_names;
  late Hobli hobliTemp;
  late List<String> taluk_names =
      []; // = ['Madikeri', 'Virajpet', 'Somwarpet'];
  int flag = 0;
  late int inc;
  String? selectedTaluk;
  late String _selectedTalluk_;

  late String temp;
  @override
  void initState() {
    super.initState();
    _getTaluk();
    _getHobli();
    _hobliNameController = TextEditingController();
    _hobliCodeController = TextEditingController();
    inc=0;
    transactionType = '';
  }

  _showHobli(Hobli hobli_ref) {
    hobliTemp = hobli_ref;
    showAddHobliDialog(transactionType);
    _hobliCodeController.text = hobli_ref.hobliCode;
    _hobliNameController.text = hobli_ref.hobliName;
  }

  _getTaluk() {
    HobliServices.getTaluk().then((talukNames) {
      setState(() {
        taluk_ = talukNames;

        return;
      });
    });
  }

  _getHobli() {
    HobliServices.getHobli().then((hobli) {
      setState(() {
        log('message hobli');
        hobli_ = hobli;
        print('Log in hobli $hobli_');
        return;
      });
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
                'Hobli Code',
                style: tableHeadingTextStyle,
              ),
            ),
            DataColumn(
              label: Text(
                'Hobli Name',
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
                          showAddHobliDialog(transactionType);
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
                          showAddHobliDialog(transactionType);
                        },
                      ),
              ),
            ),
          ],
          rows: hobli_
              .map(
                (hobliShow) => DataRow(cells: [
                  DataCell(
                    Text((++inc).toString()),
                  ),
                  DataCell(
                    Text(hobliShow.hobliCode),
                  ),
                  DataCell(
                    Text(hobliShow.hobliName),
                  ),
                  DataCell(
                    Text(hobliShow.taluk_name),
                  ),
                  DataCell(
                    Responsive.isMobile(context)
                        ? Center(
                            child: IconButton(
                              onPressed: () {
                                inc=0;
                                transactionType = "UPDATE";
                                _selectedHobli = hobliShow;
                                hobliTemp = hobliShow;

                                _showHobli(hobliShow);
                              },
                              icon: Icon(
                                Icons.edit,
                                color: secondaryColorDark,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              inc=0;
                              transactionType = "UPDATE";
                              _selectedHobli = hobliShow;
                                hobliTemp = hobliShow;
                              _showHobli(hobliShow);
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
                                inc=0;
                                _showDeleteDialog(hobliShow);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: deleteColor,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              inc=0;
                              _showDeleteDialog(hobliShow);
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
              ).toList(),
        ),
      ),
    );

  }

  _addHobli() {
    HobliServices.addHobli(_selectedTalluk_, _hobliCodeController.text,
            _hobliNameController.text)
        .then(
      (result) {
        debugPrint('Debug report: $result');

        log('HTTP result: $result');
        if ('Success' == result) {
          _getHobli();
          // _showSnackBar(context, result);
        }
        _clearValues();
      },
    );
    //Navigator.pop(context, 'Add');
  }

  void showAddHobliDialog(String transactionType) {
    //  String? value;
    showDialog<String>(
      context: context,

      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: transactionType == 'ADD'
            ? const Text(
                'Add New Hobli',
                style: tableHeadingTextStyle,
              )
            : const Text(
                'Update Hobli',
                style: tableHeadingTextStyle,
              ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.24,
          height: 220,
          child: Scaffold(
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: Colors.black45,
                        ),
                      ),
                      child: StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter dropDownState) {
                          return DropdownButtonFormField<String>(

                            hint: Padding(
                              padding: leftRightPadding,
                              child: transactionType == 'UPDATE'
                                  ? Text(hobliTemp.taluk_name)
                                  : Text('Select Taluk'),
                            ),
                            isDense: false,
                            itemHeight:kMinInteractiveDimension,
                            items: taluk_.map(buildMenuItem).toList(),
                            validator: (_selectedTaluk) {
                              if (_selectedTaluk == null &&
                                  transactionType == 'ADD') {
                                return '  Please Select Taluk  ';
                              } else if (transactionType == 'UPDATE')
                              {
                                log('else Update -');
                              }
                            },
                            onChanged: (value_) => dropDownState(() {
                              flag = 1;
                              this.selectedTaluk = value_.toString();
                              log('flag changed{$flag , $selectedTaluk}');
                              _selectedTalluk_ = value_.toString();
                            }),
                            value: selectedTaluk,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                    new TextFormField(
                      controller: _hobliCodeController,

                      decoration: new InputDecoration(
                        labelText: "Hobli Code ",
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
                          return "Hobli Code cannot be empty";
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
                      controller: _hobliNameController,
                      decoration: textFormDecoration,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Hobli Name cannot be empty";
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
                    inc=0;
                    if (_formKey.currentState!.validate()) {
                      _addHobli();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("New Hobli Added Succesfully"),
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
                    if (_formKey.currentState!.validate()) {

                      _updateHobli(_selectedHobli, selectedTaluk);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Hobli Updated Succesfully"),
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

  DropdownMenuItem<String> buildMenuItem(Taluk item) => DropdownMenuItem(
        value: item.talukCode,
        child: Padding(
          padding: leftRightPadding,
          child: Text(
            item.talukName,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      );

  _clearValues() {
    _hobliCodeController.text = "";
    _hobliNameController.text = "";
    selectedTaluk=null;

  }

  _updateHobli(Hobli selected, String? selectedTalluk)
  {
    if (_hobliCodeController.text.isEmpty ||
        _hobliNameController.text.isEmpty ||
        selectedTalluk == null) {
      print('Empty Field');
    } else {
      if (selectedTalluk.isEmpty) {
        selectedTalluk = selected.taluk_name;
        log('selected.talukname' + selected.taluk_name);
      }
      HobliServices.updateHobli(
        selectedTalluk,
        selected,
        _hobliCodeController.text,
        _hobliNameController.text,
      ).then((result) {
        debugPrint('Debug report: $result');

        log('HTTP result: $result');
        if ('Success' == result) {

          _getHobli();
          selectedTaluk=null;
          _clearValues();
          // _showSnackBar(context, result);
        }
        _clearValues();
        //  Navigator.pop(context);
      });
    }
  }

  void _deleteHobli(Hobli selected) {
    HobliServices.deleteHobli(selected).then((result) {
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
        _getHobli();
        // _showSnackBar(context, result);
      }

      Navigator.pop(context);
    });
  }

  void _showDeleteDialog(Hobli hobliObject) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
            "Are you sure want to delete the Hobli ${hobliObject.hobliName} ?"),
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
            onPressed: () => _deleteHobli(hobliObject),
          ),
        ],
      ),
    );
  }
}
