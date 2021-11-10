import 'dart:developer';

import 'package:admin/models/hobli.dart';
import 'package:admin/services/services.dart';
import 'package:admin/utilities/constants.dart';
import 'package:admin/utilities/responsive.dart';
import 'package:flutter/material.dart';

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
    Services.getHobli().then((hobli) {
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
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                'SL.NO',
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
            // DataColumn(
            //   label: Text(
            //     'Taluk Name',
            //     style: tableHeadingTextStyle,
            //   ),
            // ),
            DataColumn(
              label: Visibility(
                visible: false,
                child: Text(
                  'Edit',
                  style: tableHeadingTextStyle,
                ),
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
                          // transactionType = "ADD";
                          //  showAddTalukDialog(transactionType);
                        },
                      )
                    : TextButton(
                        child: Text(
                          "Add".toUpperCase(),
                          style: tableHeadingTextStyle,
                        ),
                        style: outlinedButtonStyle,
                        onPressed: () {
                          // transactionType = "ADD";
                          //  showAddTalukDialog(transactionType);
                        }),
              ),
            ),
          ],
          rows: hobli_
              .map(
                (hobli_data) => DataRow(
                  cells: [
                    DataCell(
                      Text(hobli_data.slNo),
                    ),
                    DataCell(
                      Text(hobli_data.hobliCode),
                    ),
                    DataCell(
                      Text(hobli_data.hobliName),
                    ),
                    DataCell(
                      Responsive.isMobile(context)
                          ? Center(
                              child: IconButton(
                                onPressed: () {
                                  transactionType = "UPDATE";
                                  _selectedHobli = hobli_data;
                                  _showHobli(hobli_data);
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
                                _selectedHobli = hobli_data;
                                _showHobli(hobli_data);
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
                                  _showDeleteDialog(hobli_data);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: deleteColor,
                                ),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                _showDeleteDialog(hobli_data);
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
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  void showAddHobliDialog(String transactionType) {
    showDialog(
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
                      //  _addTaluk();
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
                      // _updateTaluk(_selectedTaluk);
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

  _clearValues() {
    _hobliCodeController.text = "";
    _hobliNameController.text = "";
  }

  void _deleteHobli(Hobli selected) {
    log('delete hobli');
    //   Services.deleteTaluk(selected).then((result) {
    //     debugPrint('Debug report: $result');

    //     log('HTTP result: $result');
    //     if ('Success' == result) {
    //       Fluttertoast.showToast(
    //           msg: "Deleted",
    //           toastLength: Toast.LENGTH_SHORT,
    //           gravity: ToastGravity.TOP,
    //           timeInSecForIosWeb: 1,
    //           backgroundColor: Colors.red,
    //           textColor: Colors.white,
    //           fontSize: 16.0);
    //       _getTaluk();
    //       // _showSnackBar(context, result);
    //     }

    //     Navigator.pop(context);
    //   });
  }

  void _showDeleteDialog(Hobli hobliObject) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
            "Are you sure want to delete the Taluk ${hobliObject.hobliName} ?"),
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
