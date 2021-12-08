import 'dart:developer';
import 'package:intl/intl.dart';
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
  DateTime _selectedDate = DateTime.now();
  int count = 0;
  //initializing
  @override
  void initState() {
    super.initState();
    //  controller1 = ;
    controller2 = TextEditingController();
    _getTaluk();
    _getHobli();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        log(pickedDate.toString());

        return;
      }
      setState(() {
        count = count + 1;
        _selectedDate = pickedDate;
      });
    });
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
          margin: EdgeInsets.all(8.0),
          padding: defaultPadding,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              color: tableBackground),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                  Divider(
                    color: Colors.black54,
                    thickness: 1,
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(16.0),
                  //     border: Border.all(
                  //       color: Colors.red,
                  //     ),
                  //   ),

                  // ),
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
                          //  controller: controller1,
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
                          //  controller: controller1,
                          onEditingComplete: () {
                            print(controller1.text);
                          },
                          decoration: new InputDecoration(
                            labelText: "Parent or Guardian Name",
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
                              onChanged: (String? value_) => dropDownState(() {
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

                              items: hobli_.map(buildMenuItemHobli).toList(),
                              validator: (_selectedHobli) {
                                _selectedHobli == null
                                    ? 'Please Select Hobli'
                                    : 'LLL';
                              },
                              onChanged: (String? value_) => dropDownState(() {
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

                              items: hobli_.map(buildMenuItemHobli).toList(),
                              validator: (_selectedHobli) {
                                _selectedHobli == null
                                    ? 'Please Select Village'
                                    : null;
                              },
                              onChanged: (String? value_) => dropDownState(() {
                                this.selectedHobli = value_;
                              }),
                              value: selectedHobli,
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  //Date of birth

                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('Date Of Birth :'),
                        ),
                      ),
                      Expanded(
                          child: Row(
                        children: [
                          TextButton(
                            onPressed: () => _presentDatePicker(),
                            child: Text(
                              count == 0
                                  ? 'No Date choosen'
                                  : '${DateFormat.yMd().format(_selectedDate)}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )),
                    ],
                  ),
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('Occupation :'),
                        ),
                      ),
                      Expanded(
                        child: new TextFormField(
                          //  controller: controller1,
                          onEditingComplete: () {
                            print(controller1.text);
                          },
                          decoration: new InputDecoration(
                            labelText: "Your Occupation",
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
                              return "Please enter your Occupation.";
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
//Family
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                              'Whether Kodava by Race the family to which he/she belongs to  :'),
                        ),
                      ),
                      Expanded(
                        child: new TextFormField(
                          // controller: controller1,
                          onEditingComplete: () {
                            print(controller1.text);
                          },
                          decoration: new InputDecoration(
                            labelText: "Family Name",
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
                              return "Please enter your Family Name.";
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
                  //Jamma holder

                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                              'Whether Jamma Tenure holder in Kodagu ,the particulars of Jamma Holding:'),
                        ),
                      ),
                      Expanded(
                        child: new TextFormField(
                          // controller: controller1,
                          onEditingComplete: () {
                            print(controller1.text);
                          },
                          decoration: new InputDecoration(
                            labelText: "Cast Certificate Enclosed ?",
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
                              return "Please fill the details.";
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
                  // state
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                              'Area within which applicant wishes to carry arms :'),
                        ),
                      ),
                      Expanded(
                        child: new TextFormField(
                          //controller: controller1,
                          onEditingComplete: () {
                            print(controller1.text);
                          },
                          decoration: new InputDecoration(
                            labelText: "State",
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
                              return "Please fill the details.";
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

                  //Description
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                              'Description of arms ammunitions for which exemption is sought:'),
                        ),
                      ),
                      Expanded(
                        child: new TextFormField(
                          //  controller: controller1,
                          onEditingComplete: () {
                            print(controller1.text);
                          },
                          decoration: new InputDecoration(
                            labelText: "Type of Arms",
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
                              return "Please fill the details.";
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
                  //convicted
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                              'Whether the applicant has ever convicted,if so ,the offence and the sentence:'),
                        ),
                      ),
                      Expanded(
                        child: new TextFormField(
                          //controller: controller1,
                          onEditingComplete: () {
                            print(controller1.text);
                          },
                          decoration: new InputDecoration(
                            labelText: "Any Criminal Case against you?",
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
                              return "Please fill the details.";
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

//bond under chapter VII

                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                              'Whether the applicant has ever been ordered to execute a bond under chapter VII of Cr.P.C for keeping the peace or good Behaviour. If so, when and for what period:'),
                        ),
                      ),
                      Expanded(
                        child: new TextFormField(
                          //controller: controller1,
                          onEditingComplete: () {
                            print(controller1.text);
                          },
                          decoration: new InputDecoration(
                            labelText: "Fill the details",
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
                              return "Please fill the details.";
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
                  new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: new Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                              'Whether the applicant has been prohibited under the arms Act 1959 or any other law from having the arms,ammunitions:'),
                        ),
                      ),
                      Expanded(
                        child: new TextFormField(
                          //controller: controller1,
                          onEditingComplete: () {
                            print(controller1.text);
                          },
                          decoration: new InputDecoration(
                            labelText: "Prohibited under Arms Act 1959?",
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
                              return "Please fill the details.";
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
                  Divider(
                    color: Colors.black54,
                    thickness: 1,
                  ),

//Submit.
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0)),
                    constraints:
                        BoxConstraints(maxWidth: 250.0, minHeight: 50.0),
                    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: RaisedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Data Submitted Succesfully"),
                            ),
                          );
                          //Navigator.of(context).pop();
                        } else {
                          log("Error Adding");
                          return;
                        }
                      },
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 24.0),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.done,
                                color: successColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
          //controller: controller1,
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
