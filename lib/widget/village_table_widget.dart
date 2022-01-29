import 'dart:developer';

import 'package:admin/models/hobli.dart';
import 'package:admin/models/talluk.dart';
import 'package:admin/models/va_circle.dart';
import 'package:admin/models/village.dart';
import 'package:admin/services/hobli_service.dart';
import 'package:admin/services/va_circle_service.dart';
import 'package:admin/services/village_service.dart';
import 'package:admin/utilities/constants.dart';
import 'package:admin/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VillageTable extends StatefulWidget
{
  const VillageTable({Key? key}) : super(key: key);
  @override
  _VillageState createState() => _VillageState();
}
class _VillageState extends State<VillageTable> {
  late List<VACircle> va_circle_ = [];
  late List<Taluk> taluk_ = [];
  late List<Hobli> hobli_ = [];
  late List<Village> village_ = [];
  late String transactionType;

  late TextEditingController _villageNameController;
  late TextEditingController _villageCodeController;
  final _formKey = GlobalKey<FormState>();
  late Village _selectedVA;
 // late Village _selectedVillage;
  late List<String> taluk_names =[];
  String? selectedTaluk;
  late String _selectedTalluk_;
  late String _selectedVACircle_;
  late String _selectedTallukCode_;

  String? selectedHobli;
  String? selectedVACircle;
  late String _selectedHobli_;
  late String _selectedHobliCode_;
  int inc=0;
  int flag1=0;
  int flag2=0;
  int flag3=0;

  @override
  void initState()
  {
    super.initState();
    _getTaluk();
    _getHobli();
    _getVACircle();
    _getVillage();
    _villageNameController = TextEditingController();
    _villageCodeController = TextEditingController();
    transactionType = '';
  }

  _addVillage()
  {
    VillageServices.addVillage(_selectedTalluk_, _selectedHobli_,_selectedVACircle_,
        _villageCodeController.text, _villageNameController.text)
        .then(
          (result)
      {
        debugPrint('Debug report: $result');

        log('HTTP result: $result');
        if ('Success' == result) {
          _getVillage();
          // _showSnackBar(context, result);
        }
        _clearValues();
      },
    );
    //Navigator.pop(context, 'Add');
  }

  _showVillage(Village v_ref)
  {

    showAddVillageDialog(transactionType);
    _villageCodeController.text = v_ref.villlageCode;
    _villageNameController.text = v_ref.villageName;
  }

  _getTaluk()
  {
    VillageServices.getTaluk().then((talukNames)
    {
      setState(()
      {
        taluk_ = talukNames;
        return;
      });
    });
  }

  _getHobli()
  {
    VillageServices.getHobliForDropdown().then((hobli)
    {
      setState(() {
        hobli_ = hobli;
        print('Log in hobli..8 $hobli_');
        return;
      });
    });
  }

  _getVACircle() {
    VillageServices.getVAForDropdown().then((va_list) {
      setState(() {
        va_circle_ = va_list;
        log('--------'+va_list.toString());
        return;
      });
    });
  }

  _getVillage() {
    VillageServices.getVillage().then((village_list) {
      setState(() {
        village_ = village_list;
        log('village--------'+village_list.toString());
        return;
      });
    });
  }

  _updateVillage(Village selected,String? selectedTaluk1,String? selectedHobli1,String? selectedVaCircle1)
  {
    if (_villageCodeController.text.isEmpty || _villageNameController.text.isEmpty)
    {
      print('Empty Field');
    } else {
      VillageServices.updateVillage(
        selected,
        _villageCodeController.text,
        _villageNameController.text,
        selectedTaluk1,
        selectedHobli1,
        selectedVaCircle1
      ).then((result) {
        debugPrint('Debug report: $result');

        log('HTTP result: $result');
        if ('Success' == result) {
          flag1=0;
          flag2=0;
          flag3=0;
          _getVillage();

          // _showSnackBar(context, result);
        }
        _clearValues();
        //  Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    inc=0;
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
                'Village Code',
                style: tableHeadingTextStyle,
              ),
            ),
            DataColumn(
              label: Text(
                'Village Name',
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
              label: Text(
                'VACircle Name',
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
                    showAddVillageDialog(transactionType);
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
                      showAddVillageDialog(transactionType);
                    }),
              ),
            ),
          ],
          rows: village_
              .map(
                (vaShow) => DataRow(cells: [
              DataCell(
                Text((++inc).toString()),
              ),
              DataCell(
                Text(vaShow.villlageCode),
              ),
              DataCell(
                Text(vaShow.villageName),
              ),
              DataCell(
                Text(vaShow.talukName),
              ),
              DataCell(
                Text(vaShow.hobliName),
              ),
                  DataCell(
                    Text(vaShow.VACircleName),
                  ),
              DataCell(
                Responsive.isMobile(context)
                    ? Center(
                  child: IconButton(
                    onPressed: () {
                      inc=0;
                      transactionType = "UPDATE";
                      _selectedVA = vaShow;
                      _showVillage(vaShow);
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
                    _selectedVA = vaShow;
                    _showVillage(vaShow);
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
                    inc=0;
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
  void showAddVillageDialog(String transactionType) {
    //  String? value;
    flag1=flag2=flag3=0;
    showDialog<String>(

      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: transactionType == 'ADD'
            ? const Text(
          'Add New Village',
          style: tableHeadingTextStyle,
        )
            : const Text(
          'Update Village',
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
                            hint: transactionType == 'UPDATE'
                                ? Text(_selectedVA.talukName)
                                : Text('Select Taluk'),


                            items: taluk_.map(buildMenuItem).toList(),

                            onChanged: (String? value_) => dropDownState(() {

                              this.selectedTaluk = value_;
                              selectedTaluk=_selectedTalluk_ = value_.toString();
                              flag1=1;

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
                            hint: transactionType == 'UPDATE'
                                ? Text(_selectedVA.hobliName)
                                : Text('Select Hobli'),

                            items: hobli_.map(buildMenuItemHobli).toList(),

                            onChanged: (String? value_) => dropDownState(()
                            {

                              this.selectedHobli = value_;
                              _selectedHobli_ = value_.toString();
                              log('hobli sss $_selectedHobli_--- $selectedHobli');
                              flag2=1;
                            } ),
                            value: selectedHobli,
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
                      child: StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter dropDownState) {
                          return DropdownButtonFormField<String>(
                            elevation: 16,
                            hint: transactionType == 'UPDATE'
                                ? Text(_selectedVA.VACircleName)
                                : Text('Select VA Circle'),

                            items: va_circle_.map(buildMenuItemVA).toList(),

                            onChanged: (String? value_) => dropDownState(() {

                              this.selectedVACircle = value_;
                            _selectedVACircle_ = value_.toString();
                              log('VA sel: $_selectedVACircle_--- $selectedVACircle');
                              flag3=1;

                            }),
                            value: selectedVACircle,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                    ),
                    new TextFormField(
                      controller: _villageCodeController,

                      decoration: new InputDecoration(
                        labelText: "Village Code ",
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
                          return "Village Code cannot be empty";
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
                      controller: _villageNameController,
                      decoration: textFormDecoration,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Village Name cannot be empty";
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
                _addVillage();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("New Village Added Succesfully"),
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
              inc=0;
              print('flag value $flag1 , $flag2 , $flag3');

              if (_formKey.currentState!.validate()) {
                if(flag1==0){
                  selectedTaluk=_selectedVA.taluk_code;
                }
                if(flag2==0)
                {
                  selectedHobli=_selectedVA.hobli_code;
                } if(flag3==0)
                {
                  selectedVACircle=_selectedVA.VACircleCode;
                }

                _updateVillage(_selectedVA,selectedTaluk,selectedHobli,selectedVACircle);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Village Updated Succesfully"),
                  ),
                );
                Navigator.of(context).pop();
              } else {
                log("Error Updating Village");
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
  DropdownMenuItem<String> buildMenuItemVA(VACircle item) => DropdownMenuItem(
    value: item.VACircleCode,
    child: Padding(
      padding: leftRightPadding,
      child: Text(
        item.VACircleName,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ),
  );

  _clearValues() {
    selectedHobli=null;
    selectedTaluk=null;
    selectedVACircle=null;
    _villageCodeController.text = "";
    _villageNameController.text = "";
  }

  void _deleteVillage(Village selected) {
    VillageServices.deleteVillage(selected).then((result) {
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
        _getVillage();
        // _showSnackBar(context, result);
      }

      Navigator.pop(context);
    });
  }

  void _showDeleteDialog(Village villageObject) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
            "Are you sure want to delete the Village ${villageObject.villageName} ?"),
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
            onPressed: () => _deleteVillage(villageObject),
          ),
        ],
      ),
    );
  }
}
