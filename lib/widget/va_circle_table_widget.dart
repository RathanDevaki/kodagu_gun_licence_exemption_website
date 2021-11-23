import 'dart:developer';

import 'package:admin/models/hobli.dart';
import 'package:admin/models/talluk.dart';
import 'package:admin/models/va_circle.dart';
import 'package:admin/services/hobli_service.dart';
import 'package:admin/services/va_circle_service.dart';
import 'package:admin/utilities/constants.dart';
import 'package:admin/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VACircleTable extends StatefulWidget {
  const VACircleTable({Key? key}) : super(key: key);

  @override
  _VACircleTableState createState() => _VACircleTableState();
}

// hey
class _VACircleTableState extends State<VACircleTable> {
  late List<VACircle> va_circle_ = [];
  late List<Taluk> taluk_ = [];
  late List<Hobli> hobli_ = [];

  late String transactionType;
  late TextEditingController _vaCircleNameController;
  late TextEditingController _vaCircleCodeController;
  final _formKey = GlobalKey<FormState>();
  late VACircle _selectedVA;
  // late List taluk_names;

  late List<String> taluk_names =
      []; // = ['Madikeri', 'Virajpet', 'Somwarpet'];

  String? selectedTaluk;
  late String _selectedTalluk_;
  late String _selectedTallukCode_;

  String? selectedHobli;
  String? tempselectedHobli;
  late String _selectedHobli_;
  late String _selectedHobliCode_;
  @override
  void initState() {
    super.initState();
    _getTaluk();
    _getHobli();
    _getVACircle();
    _vaCircleNameController = TextEditingController();
    _vaCircleCodeController = TextEditingController();
    tempselectedHobli = 'Bhaguuu';
    transactionType = '';
  }

  _addVACircle() {
    VACircleServices.addVACircle(_selectedTalluk_, _selectedHobli_,
            _vaCircleCodeController.text, _vaCircleNameController.text)
        .then(
      (result) {
        debugPrint('Debug report: $result');

        log('HTTP result: $result');
        if ('Success' == result) {
          _getVACircle();
          // _showSnackBar(context, result);
        }
        _clearValues();
      },
    );
    //Navigator.pop(context, 'Add');
  }

  _showVACircle(VACircle vaCircle_ref) {
    showAddVACircleDialog(transactionType);
    _vaCircleCodeController.text = vaCircle_ref.VACircleCode;
    _vaCircleNameController.text = vaCircle_ref.VACircleName;
  }

  _getVACircle() {
    VACircleServices.getVACircle().then((va_list) {
      setState(() {
        va_circle_ = va_list;

        return;
      });
    });
  }

  _getTaluk() {
    VACircleServices.getTaluk().then((talukNames) {
      setState(() {
        taluk_ = talukNames;

        return;
      });
    });
  }

  _getHobli() {
    VACircleServices.getHobli().then((hobli) {
      setState(() {
        hobli_ = hobli;
        print('Log in hobli $hobli_');
        return;
      });
    });
  }

  _updateVACircle(VACircle selected) {
    if (_vaCircleCodeController.text.isEmpty ||
        _vaCircleNameController.text.isEmpty) {
      // print('Empty Field');
    } else {
      VACircleServices.updateVACircle(
        selected,
        _vaCircleCodeController.text,
        _vaCircleNameController.text,
      ).then((result) {
        debugPrint('Debug report: $result');

        log('HTTP result: $result');
        if ('Success' == result) {
          _getVACircle();
          // _showSnackBar(context, result);
        }
        _clearValues();
        //  Navigator.pop(context);
      });
    }
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
                'VA Circle Code',
                style: tableHeadingTextStyle,
              ),
            ),
            DataColumn(
              label: Text(
                'VA Circle Name',
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
                          showAddVACircleDialog(transactionType);
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
                          showAddVACircleDialog(transactionType);
                        }),
              ),
            ),
          ],
          rows: va_circle_
              .map(
                (vaShow) => DataRow(cells: [
                  DataCell(
                    Text(vaShow.slNo),
                  ),
                  DataCell(
                    Text(vaShow.VACircleCode),
                  ),
                  DataCell(
                    Text(vaShow.VACircleName),
                  ),
                  DataCell(
                    Text(vaShow.talukCode),
                  ),
                  DataCell(
                    Text(vaShow.hobliCode),
                  ),
                  DataCell(
                    Responsive.isMobile(context)
                        ? Center(
                            child: IconButton(
                              onPressed: () {
                                transactionType = "UPDATE";
                                _selectedVA = vaShow;
                                _showVACircle(vaShow);
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
                              _selectedVA = vaShow;
                              _showVACircle(vaShow);
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
                                _showDeleteDialog(vaShow);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: deleteColor,
                              ),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              _showDeleteDialog(vaShow);
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

  void showAddVACircleDialog(String transactionType) {
    //  String? value;
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: transactionType == 'ADD'
            ? const Text(
                'Add New VA Circle',
                style: tableHeadingTextStyle,
              )
            : const Text(
                'Update VA Circle',
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
                            elevation: 16,
                            hint: Padding(
                              padding: leftRightPadding,
                              child: Text('Select Taluk'),
                            ),
                            // taluk_names.map(buildMenuItem).toList()
                            items: taluk_.map(buildMenuItem).toList(),
                            validator: (_selectedTaluk) =>
                                _selectedTaluk == null
                                    ? '  Please Select Taluk  '
                                    : null,
                            onChanged: (String? value_) => dropDownState(() {
                              this.selectedTaluk = value_;
                              _selectedTalluk_ = value_.toString();
                              log(_selectedTalluk_);
                            }),
                            value: selectedTaluk,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: Colors.black45,
                        ),
                      ),
                      //hei
                      child: StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter dropDownState) {
                          return DropdownButtonFormField<String>(
                            elevation: 16,
                            hint: Padding(
                              padding: leftRightPadding,
                              child: Text('Select Hobli'),
                            ),
                            // taluk_names.map(buildMenuItem).toList()
                            items: hobli_.map(buildMenuItemHobli).toList(),
                            validator: (_selectedHobli) =>
                                _selectedHobli == null
                                    ? '  Please Select Hobli  '
                                    : null,
                            onChanged: (String? value_) => dropDownState(() {
                              this.selectedHobli = value_;
                              _selectedHobli_ = value_.toString();
                              log('hobli $_selectedHobli_');
                            }),
                            value: selectedHobli,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                    new TextFormField(
                      controller: _vaCircleCodeController,

                      decoration: new InputDecoration(
                        labelText: "VA Circle Code ",
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
                          return "VA Circle Code cannot be empty";
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
                      controller: _vaCircleNameController,
                      decoration: textFormDecoration,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "VA Circle Name cannot be empty";
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
                      _addVACircle();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("New VA Circle Added Succesfully"),
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
                      _updateVACircle(_selectedVA);
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
  DropdownMenuItem<String> buildMenuItemHobli(Hobli item) => DropdownMenuItem(
        value: item.hobliCode,
        child: Padding(
          padding: leftRightPadding,
          child: Text(
            item.hobliName,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      );

  _clearValues() {
    _vaCircleCodeController.text = "";
    _vaCircleNameController.text = "";
  }

  void _deleteVACircle(VACircle selected) {
    VACircleServices.deleteVACircle(selected).then((result) {
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
        _getVACircle();
        // _showSnackBar(context, result);
      }

      Navigator.pop(context);
    });
  }

  void _showDeleteDialog(VACircle vaCircleObject) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
            "Are you sure want to delete the VA Circle ${vaCircleObject.VACircleName} ?"),
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
            onPressed: () => _deleteVACircle(vaCircleObject),
          ),
        ],
      ),
    );
  }
}
