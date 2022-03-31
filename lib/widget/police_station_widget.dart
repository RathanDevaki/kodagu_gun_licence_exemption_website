import 'dart:developer';

import 'package:admin/models/hobli.dart';
import 'package:admin/models/station.dart';
import 'package:admin/models/talluk.dart';
import 'package:admin/services/hobli_service.dart';
import 'package:admin/services/station_service.dart';
import 'package:admin/utilities/constants.dart';
import 'package:admin/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PoliceStationTable extends StatefulWidget {
  const PoliceStationTable({Key? key}) : super(key: key);

  @override
  _PoliceStationState createState() => _PoliceStationState();
}

class _PoliceStationState extends State<PoliceStationTable> {
  final _formKey = GlobalKey<FormState>();
  static const double kMinInteractiveDimension = 48.0;

  late List<Station> station_ = [];
  late List<Taluk> taluk_ = [];
  late String transactionType;

  late TextEditingController _stationNameController_en;
  late TextEditingController _stationNameController_ka;
  late TextEditingController _stationCodeController;


  late Station _selectedStation;
  // late List taluk_names;
  late Station stationTemp;
  late List<String> taluk_names = []; // = ['Madikeri', 'Virajpet', 'Somwarpet'];
  int flag = 0;
  late int inc;

  String? selectedTaluk;
  late String _selectedTalluk_;
  bool isSwitched=false;

  late String temp;
  @override
  void initState() {
    super.initState();
    _getTaluk();
    _getStation();
    _stationNameController_en = TextEditingController();
    _stationCodeController = TextEditingController();
    _stationNameController_ka = TextEditingController();
    inc=0;
    transactionType = '';
  }

  _showStation(Station station_ref) {
    stationTemp = station_ref;
    showAddStationDialog(transactionType);
    _stationCodeController.text = station_ref.station_code;
    _stationNameController_en.text = station_ref.station_name_en;
    _stationNameController_ka.text=station_ref.station_name_ka;
  }

  _getTaluk() {
    StationServices.getTaluk().then((talukNames) {
      setState(() {
        taluk_= talukNames;

        return;
      });
    });
  }

  _getStation() {
    StationServices.getStation().then((station1) {
      setState(() {
        log('message Station');
        station_ = station1;
        print('Log in _getStation $station_');
        return;
      });
    });
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
          dataRowHeight: 32,
          columnSpacing: MediaQuery.of(context).size.width * 0.01,
          sortColumnIndex: 1,
          sortAscending: true,
          columns: [
            DataColumn(
              label: Text(
                'SL. NO',
                style: tableHeadingTextStyle,
              ),
             // label: Switch(
             //    value: isSwitched,
             //    onChanged: (value) {
             //      setState(() {
             //        isSwitched = value;
             //        print(isSwitched);
             //      });
             //    },
             //    activeTrackColor: Colors.lightGreenAccent,
             //    activeColor: Colors.green,
             //  ),
            ),
            DataColumn(
              label: Text(
                'Station Code',
                style: tableHeadingTextStyle,
              ),
            ),
            DataColumn(
              label: Text(
                'Station Name',
                style: tableHeadingTextStyle,
              ),
            ),  DataColumn(
              label: Text(
                'ಠಾಣೆ ಹೆಸರು',
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
                    showAddStationDialog(transactionType);
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
                    showAddStationDialog(transactionType);
                  },
                ),
              ),
            ),
          ],
          rows: station_
              .map(
                (stationShow) => DataRow(cells: [
              DataCell(
                SelectableText((++inc).toString()),
              ),
              DataCell(
                SelectableText(stationShow.station_code),
              ),
              DataCell(
                SelectableText(stationShow.station_name_en),
              ),
                  DataCell(
                    SelectableText(stationShow.station_name_ka),
                  ),
              DataCell(
                SelectableText(stationShow.taluk_name),
              ),
              DataCell(
                Responsive.isMobile(context)
                    ? Center(
                  child: IconButton(
                    onPressed: () {
                      inc=0;
                      transactionType = "UPDATE";
                      _selectedStation = stationShow;
                      stationTemp = stationShow;

                      _showStation(stationShow);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: secondaryColorDark,
                      size: 16,
                    ),
                  ),
                )
                    : ElevatedButton(
                  onPressed: () {
                    inc=0;
                    transactionType = "UPDATE";
                    _selectedStation = stationShow;
                    stationTemp = stationShow;
                    _showStation(stationShow);
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

                      log('Stationdelete'+stationShow.station_code);
                      _showDeleteDialog(stationShow);
                    },
                    icon: Icon(
                      Icons.delete,
                      color: deleteColor,
                      size: 16,
                    ),
                  ),
                )
                    : ElevatedButton(
                  onPressed: () {
                    inc=0;
                    log('Stationdelete '+stationShow.station_code);
                    _showDeleteDialog(stationShow);
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

  _addStation()
  {
    StationServices.addStation(_selectedTalluk_, _stationCodeController.text,
        _stationNameController_en.text,_stationNameController_ka.text)
        .then(
          (result) {
        debugPrint('Debug report: $result');

        log('HTTP result: $result');
        if ('Success' == result) {
          _getStation();
          // _showSnackBar(context, result);
        }
        _clearValues();
      },
    );
    //Navigator.pop(context, 'Add');
  }

  void showAddStationDialog(String transactionType)
  {
    flag=0;
    showDialog<String>(
      context: context,

      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: transactionType == 'ADD'
            ? const Text(
          'Add New Station',
          style: tableHeadingTextStyle,
        )
            : const Text(
          'Update Station',
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
                            decoration: InputDecoration(
                                enabledBorder:InputBorder.none),
                            hint: Padding(
                              padding: leftRightPadding,
                              child: transactionType == 'UPDATE'
                                  ? Text(stationTemp.taluk_name)
                                  : Text('Select Taluk'),
                            ),

                            items: taluk_.map(buildMenuItem).toList(),
                            validator: (_selectedTaluk) {
                              if (_selectedTaluk == null &&
                                  transactionType == 'ADD') {
                                return '  Please Select Taluk  ';
                              } else if (transactionType == 'UPDATE')
                              {
                                log('else Update - hint');
                              }
                            },
                            onChanged: (value_) => dropDownState(() {

                              this.selectedTaluk = value_.toString();
                              log('flag changed{$flag , $selectedTaluk}');
                              _selectedTalluk_ = value_.toString();
                              flag = 1;
                            }),
                            value: selectedTaluk,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                    ),
                    new TextFormField(
                      controller: _stationCodeController,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                      ],
                      decoration: new InputDecoration(
                        labelText: "Station Code ",
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
                          return "Station Code cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      //keyboardType: TextInputType.multiline,
                      style: new TextStyle(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                    ),
                    new TextFormField(
                      controller: _stationNameController_en,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                      ],
                      decoration: new InputDecoration(
                        labelText: "Station Name ",
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
                          return "Station Name cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      //keyboardType: TextInputType.multiline,
                      style: new TextStyle(),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                    ),

                    new TextFormField(
                      controller: _stationNameController_ka,

                      decoration: new InputDecoration(
                        labelText: "ಠಾಣೆ ಹೆಸರು",
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
                          return "Station Name cannot be empty";
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
                _addStation();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("New Station Added Succesfully"),
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
                if(flag==0){
                  selectedTaluk=stationTemp.taluk_code;
                }
                _updateStation(_selectedStation, selectedTaluk,flag);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Station Updated Succesfully"),
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
    _stationCodeController.text = "";
    _stationNameController_en.text = "";
    _stationNameController_ka.text = "";
    selectedTaluk=null;

  }

  _updateStation(Station selected, String? selectedTalluk,int flag)
  {
    if (_stationCodeController.text.isEmpty ||
        _stationNameController_en.text.isEmpty ||_stationNameController_ka.text.isEmpty ||
    selectedTalluk == null) {
      print('Empty Field');
    } else {
      if (selectedTalluk.isEmpty) {
        selectedTalluk = selected.taluk_name;
        log('selected.talukname' + selected.taluk_name);
      }

      StationServices.updateStation(
        selectedTalluk,
        selected,
        _stationCodeController.text,
        _stationNameController_en.text,_stationNameController_ka.text,
      ).then((result) {
        debugPrint('Debug report: $result');

        log('HTTP result: $result');
        if ('Success' == result) {

          _getStation();

          _clearValues();
          // _showSnackBar(context, result);
        }
        _getStation();
        _clearValues();
        //  Navigator.pop(context);
      });
    }
  }

  void _showDeleteDialog(Station stationObject) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
            "Are you sure want to delete the Station ${stationObject.station_name_en} ?"),
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
            onPressed: () {
              String st_name=stationObject.station_code;
              StationServices.deleteStation(st_name).then((result) {
                debugPrint('Debug report station: $result');

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
                  _getStation();
                  // _showSnackBar(context, result);
                }

                Navigator.pop(context);
              });
              _getStation();
            },
          ),
        ],
      ),
    );
  }
}
