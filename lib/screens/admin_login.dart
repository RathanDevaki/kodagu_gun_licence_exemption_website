import 'dart:developer';

import 'dart:ui';

import 'package:admin/models/admin_login.dart';
import 'package:admin/services/login_service.dart';
import 'package:admin/utilities/constants.dart';
import 'package:admin/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdminLoginPage extends StatefulWidget
{
  const AdminLoginPage({Key? key}) : super(key: key);

  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLoginPage> {

  final _formKey =GlobalKey<FormState>();
  late List<AdminLogin> _login_data= [];
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late AdminLogin admin_data;
  @override
  void initState(){
    _getAdminLogin1();
    _usernameController=TextEditingController();
    _passwordController = TextEditingController();
  }
_getAdminLogin(String _username,String _password){
    LoginServices.getAdminLogin(_username,_password).then((_login) {
      setState(()
      {
         _login_data=_login;
        return;
      },);

    },);

}
  _getAdminLogin1(){
    LoginServices.getAdminLogin1().then((_login) {
      setState(()
      {
        _login_data=_login;

        return;
      },);

    },);

  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        body:Form(key:_formKey, child:Center(

        child:Container(
          //color: secondaryColor,
           padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0),color: tableBackground, boxShadow: [BoxShadow(
          color: Colors.grey,
          blurRadius: 16.0,
        ),]),
        width: 500,

        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize:MainAxisSize.min,
      children: [
        Visibility(visible:false,child:DataTable(
          columns: [
            DataColumn(label: Text('UID'),),
          ],
          rows: _login_data
              .map(
                (login_obj) => DataRow(cells: [
              DataCell(
                SelectableText((admin_data=login_obj).toString()),
              ),

            ],),
          )
              .toList(),
        ),),



        new TextFormField(
         controller: _usernameController,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],

          decoration: new InputDecoration(
            labelText: "Enter Login ID",
            contentPadding: EdgeInsets.only(left: 30),
            prefixIcon: Icon(Icons.person),
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
              return "Login ID cannot be empty";
            } else {
              return null;
            }
          },
          //keyboardType: TextInputType.multiline,
          style: new TextStyle(),
        ),
        SizedBox(height: 30),
        new TextFormField(
           controller: _passwordController,
          //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],

          decoration: new InputDecoration(
            prefixIcon: Icon(Icons.vpn_key),
            labelText: "Enter Password",
            contentPadding: EdgeInsets.only(left: 30),
            labelStyle: TextStyle(fontSize: 14),
            fillColor: Colors.amber,
            suffixIcon: IconButton(icon:Icon(Icons.visibility_off_outlined),onPressed:(){print('v');},color: Colors.grey,),

            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(16.0),
              borderSide: new BorderSide(),
            ),
            //fillColor: Colors.green
          ),

          validator: (val) {
            if (val == null || val.isEmpty) {
              return "Please enter your password";
            } else {
              return null;
            }
          },
          //keyboardType: TextInputType.multiline,
          style: new TextStyle(),
        ),

        SizedBox(height: 40),
        Padding( padding:EdgeInsets.symmetric(horizontal: 8,vertical: 16,),child:Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black45,
                spreadRadius: 8,
                blurRadius: 16,
                blurStyle: BlurStyle.normal,
              ),
            ],
          ),
          child:ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Text("Sign In"),),),
            onPressed: () async {

                if(_formKey.currentState!.validate()){
                  log('Pressed-'+_passwordController.text+'--'+_usernameController.text);
                  await _getAdminLogin(_usernameController.text,_passwordController.text);
                  log('pre='+admin_data.user_id);
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),),
        ),

      ],
    ),),),),);
  }
}

