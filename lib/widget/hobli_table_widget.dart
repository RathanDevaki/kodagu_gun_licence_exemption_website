import 'dart:developer';

import 'package:admin/models/hobli.dart';
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
  late List<Hobli> hobli_ = [];
  late String transactionType;
  late TextEditingController _hobliNameController;
  late TextEditingController _hobliCodeController;
  final _formKey = GlobalKey<FormState>();
  late Hobli _selectedHobli;
  // late List taluk_names;
  List<String> taluk_names = ['Madikeri', 'Virajpet', 'Somwarpet'];

  String? selectedTaluk;

  @override
  void initState() {
    super.initState();
    _hobliNameController = TextEditingController();
    _hobliCodeController = TextEditingController();
    transactionType = '';

    _getHobli();
    // TODO: implement initState
  }

  _showHobli(Hobli hobli_ref) {
    showAddHobliDialog(transactionType);
    _hobliCodeController.text = hobli_ref.hobliCode;
    _hobliNameController.text = hobli_ref.hobliName;
  }

  _getHobli() {
    HobliServices.getHobli().then((hobli) {
      setState(() {
        hobli_ = hobli;
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
                        }),
              ),
            ),
          ],
          rows: hobli_
              .map(
                (hobliShow) => DataRow(cells: [
                  DataCell(
                    Text(hobliShow.slNo),
                  ),
                  DataCell(
                    Text(hobliShow.hobliCode),
                  ),
                  DataCell(
                    Text(hobliShow.hobliName),
                  ),
                  DataCell(
                    Responsive.isMobile(context)
                        ? Center(
                            child: IconButton(
                              onPressed: () {
                                transactionType = "UPDATE";
                                _selectedHobli = hobliShow;
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
                              transactionType = "UPDATE";
                              _selectedHobli = hobliShow;
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
              )
              .toList(),
        ),
      ),
    );
  }

  _addHobli() {
    if (_hobliCodeController.text.isEmpty ||
        _hobliNameController.text.isEmpty) {
    } else {
      HobliServices.addHobli(
              _hobliCodeController.text, _hobliNameController.text)
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
    }
    //Navigator.pop(context, 'Add');
  }

  void showAddHobliDialog(String transactionType) {
    //  String? value;
    showDialog<String>(
      context: context,
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
          height: 180,
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
                          builder: (BuildContext context,
                              StateSetter dropDownState) {
                            return DropdownButton<String>(
                              hint: Text('Select Taluk'),
                              items: taluk_names.map(buildMenuItem).toList(),
                              onChanged: (String? value_) => dropDownState(() {
                                this.selectedTaluk = value_;
                              }),
                              value: selectedTaluk,
                            );
                          },
                        )),
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
                        if (val!.length == 0) {
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
                      _updateHobli(_selectedHobli);
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: tableHeadingTextStyle,
        ),
      );
  _clearValues() {
    _hobliCodeController.text = "";
    _hobliNameController.text = "";
  }

  _updateHobli(Hobli selected) {
    String sl_no_ = selected.slNo;
    if (_hobliCodeController.text.isEmpty ||
        _hobliNameController.text.isEmpty) {
      // print('Empty Field');
    } else {
      HobliServices.updateHobli(
              _hobliCodeController.text, _hobliNameController.text, sl_no_)
          .then((result) {
        debugPrint('Debug report: $result');

        log('HTTP result: $result');
        if ('Success' == result) {
          _getHobli();
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
