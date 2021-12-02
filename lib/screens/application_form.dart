import 'dart:developer';

import 'package:admin/models/hobli.dart';
import 'package:admin/models/talluk.dart';
import 'package:admin/services/hobli_service.dart';
import 'package:admin/utilities/constants.dart';
import 'package:admin/widget/appbar.dart';
import 'package:flutter/material.dart';

class ApplicationForm extends StatefulWidget {
  const ApplicationForm({Key? key}) : super(key: key);

  @override
  State<ApplicationForm> createState() => _ApplicationFormState();
}

class _ApplicationFormState extends State<ApplicationForm> {
  final _formKey = GlobalKey<FormState>();
  static TextEditingController controller1 = TextEditingController();
  static late TextEditingController controller2;
  late List<Taluk> taluk_ = [];
  late List<Hobli> hobli_ = [];
  String? selectedTaluk;
  String? selectedHobli;
  //initializing
  @override
  void initState() {
    super.initState();
    //  controller1 = ;
    controller2 = TextEditingController();
    _getTaluk();
    _getHobli();
  }

//get taluk

  _getTaluk() {
    log('message');
    HobliServices.getTaluk().then((talukNames) {
      setState(() {
        taluk_ = talukNames;
        log('getTq' + taluk_.toString());
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
    return Scaffold(
      appBar: CommonAppBar(),
      backgroundColor: bgColor,
      body: Center(
        child: Container(
          color: bgColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: defaultPadding,
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Application for exemption certificate by members of kodava race and jamma tenure holders'
                              .toUpperCase(),
                          textAlign: TextAlign.center,
                          style: tableHeadingTextStyle,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: Colors.black38,
                            ),
                          ),
                          // child: StatefulBuilder(
                          //   builder:
                          //       (BuildContext context, StateSetter dropDownState) {
                          //     return DropdownButtonFormField<String>(
                          //       elevation: 16,
                          //       hint: Padding(
                          //         padding: leftRightPadding,
                          //         child: Text('Select Taluk'),
                          //       ),
                          //       // taluk_names.map(buildMenuItem).toList()

                          //       items: taluk_.map(buildMenuItem).toList(),
                          //       validator: (_selectedTaluk) {

                          //       },
                          //       onChanged: (String? value_) => dropDownState(() {

                          //       }),
                          //       value: selectedTaluk,
                          //     );
                          //   },
                          // ),
                        ),
                        // nameField,
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: new Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text('Name :'),
                              ),
                            ),
                            Expanded(
                              child: new TextFormField(
                                controller: controller1,
                                onEditingComplete: () {
                                  print(controller1.text);
                                },
                                decoration: new InputDecoration(
                                  labelText: "Name",
                                  labelStyle: TextStyle(fontSize: 14),
                                  fillColor: Colors.amber,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(16.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Please enter your name.";
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
                        //Guardian Field
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: new Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text('Parent or Guardian Name :'),
                              ),
                            ),
                            Expanded(
                              child: new TextFormField(
                                controller: controller1,
                                onEditingComplete: () {
                                  print(controller1.text);
                                },
                                decoration: new InputDecoration(
                                  labelText: "Parent or Guardian Name",
                                  labelStyle: TextStyle(fontSize: 14),
                                  fillColor: Colors.amber,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(16.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return "Please enter Parent or Guardian Name.";
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
                        //Taluk field
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: new Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text('Taluk :'),
                              ),
                            ),
                            Expanded(
                              child: StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter dropDownState) {
                                  return DropdownButtonFormField<String>(
                                    elevation: 16,
                                    hint: Padding(
                                      padding: leftRightPadding,
                                      child: Text('Select Taluk'),
                                    ),
                                    // taluk_names.map(buildMenuItem).toList()

                                    items: taluk_.map(buildMenuItem).toList(),
                                    validator: (_selectedTaluk) {
                                      _selectedTaluk == null
                                          ? 'Please Select Taluk'
                                          : null;
                                    },
                                    onChanged: (String? value_) =>
                                        dropDownState(() {
                                      this.selectedTaluk = value_;
                                    }),
                                    value: selectedTaluk,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        //Hobli Field
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: new Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text('Hobli :'),
                              ),
                            ),
                            Expanded(
                              child: StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter dropDownState) {
                                  return DropdownButtonFormField<String>(
                                    elevation: 16,
                                    hint: Padding(
                                      padding: leftRightPadding,
                                      child: Text('Select Hobli'),
                                    ),
                                    // taluk_names.map(buildMenuItem).toList()

                                    items:
                                        hobli_.map(buildMenuItemHobli).toList(),
                                    validator: (_selectedHobli) {
                                      _selectedHobli == null
                                          ? 'Please Select Hobli'
                                          : null;
                                    },
                                    onChanged: (String? value_) =>
                                        dropDownState(() {
                                      this.selectedHobli = value_;
                                    }),
                                    value: selectedHobli,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

//Village
                        new Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Expanded(
                              child: new Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Text('Village :'),
                              ),
                            ),
                            Expanded(
                              child: StatefulBuilder(
                                builder: (BuildContext context,
                                    StateSetter dropDownState) {
                                  return DropdownButtonFormField<String>(
                                    elevation: 16,
                                    hint: Padding(
                                      padding: leftRightPadding,
                                      child: Text('Select Village'),
                                    ),
                                    // taluk_names.map(buildMenuItem).toList()

                                    items:
                                        hobli_.map(buildMenuItemHobli).toList(),
                                    validator: (_selectedHobli) {
                                      _selectedHobli == null
                                          ? 'Please Select Village'
                                          : null;
                                    },
                                    onChanged: (String? value_) =>
                                        dropDownState(() {
                                      this.selectedHobli = value_;
                                    }),
                                    value: selectedHobli,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),

                        // ListTile(
                        //   leading: Text('Addess :'),
                        //   title: buildTextField(labelText: 'Your Address'),
                        // ),
                        // ListTile(
                        //   leading: Text('Occupation :'),
                        //   title: buildTextField(labelText: 'Your Occupation'),
                        //),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  var nameField = new Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Expanded(
        child: new Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text('Name :'),
        ),
      ),
      Expanded(
        child: new TextFormField(
          controller: controller1,
          onEditingComplete: () {
            print(controller1.text);
          },
          decoration: new InputDecoration(
            labelText: "Name",
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
              return "Please enter your name.";
            } else {
              return null;
            }
          },
          //keyboardType: TextInputType.multiline,
          style: new TextStyle(),
        ),
      ),
    ],
  );

  Widget buildTextField({required String labelText}) {
    return Container(
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(fontSize: 14),
          fillColor: Colors.white,

          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(16.0),
            borderSide: new BorderSide(color: Colors.green),
          ),
          //fillColor: Colors.green
        ),
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
}
