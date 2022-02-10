import 'dart:developer';

import 'dart:ui';

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
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  @override
  void initState(){
    _usernameController=TextEditingController();
    _passwordController = TextEditingController();
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
        new TextFormField(
         controller: _usernameController,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],

          decoration: new InputDecoration(
            labelText: "Enter Login ID",
            contentPadding: EdgeInsets.only(left: 30),

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
            onPressed: () {


                if(_formKey.currentState!.validate()){
                  log('Pressed');

                log(_passwordController.text+' -- '+_usernameController.text);}
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
        // SizedBox(height: 40),
        // Row(children: [
        //   Expanded(
        //     child: Divider(
        //       color: Colors.grey[300],
        //       height: 50,
        //     ),
        //   ),
        //   Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 20),
        //     child: Text("Or continue with"),
        //   ),
        //   Expanded(
        //     child: Divider(
        //       color: Colors.grey[400],
        //       height: 50,
        //     ),
        //   ),
        // ]),
        // SizedBox(height: 40),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     // _loginWithButton(image: 'images/google.png'),
        //     // _loginWithButton(image: 'images/github.png', isActive: true),
        //     // _loginWithButton(image: 'images/facebook.png'),
        //   ],
        // ),
      ],
    ),),),),);
  }
}

