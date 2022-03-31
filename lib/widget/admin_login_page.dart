import 'dart:async';
import 'dart:convert';
import 'package:admin/screens/home_screen.dart';
import 'package:admin/utilities/responsive.dart';

import 'package:loading_animations/loading_animations.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'footer.dart';

class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _LoginPage();
  }
}

class _LoginPage extends State<LoginPage>{
  bool _visible = false;
  late String errormsg;
  late bool error, showprogress;
  late String user_id, password;
  final _formKey =GlobalKey<FormState>();
  var _user_id = TextEditingController();
  var _password = TextEditingController();
  var action = 'CREATE_ADMIN_LOGIN';
  startLogin() async {
    String apiurl =  "http://localhost/kodagu_gun_licence_exemption_website/log.php";

    print(user_id +'-'+password);

    var response = await http.post(Uri.parse(apiurl), body: {
      'sction' : action,
      'user_id': user_id, //get the username text
      'password': password  //get password text
    });

    if(response.statusCode == 200){
      var jsondata = json.decode(response.body);
      if(jsondata["error"]){
        setState(() {
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = jsondata["message"];
        });
      }else{
        if(jsondata["success"]){
          setState(() {
            error = false;
            showprogress = true;
            Future.delayed(const Duration(seconds: 2), () {
// Here you can write your code

              setState(() {
                showprogress = false;
                Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(),));
              });

            });


          });
          //save the data returned from server
          //and navigate to home page
          String uid = jsondata["user_id"];
          String fullname = jsondata["full_name"];
         // String address = jsondata["address"];
          print(fullname);
          //user shared preference to save data
        }else{
          showprogress = false; //don't show progress indicator
          error = true;
          errormsg = "Something went wrong.";
        }
      }
    }else{
      setState(() {
        showprogress = false; //don't show progress indicator
        error = true;
        errormsg = "Error during connecting to server.";
      });
    }
  }

  @override
  void initState() {
    user_id = "";
    password = "";
    errormsg = "";
    error = false;
    showprogress = false;

    //_username.text = "defaulttext";
    //_password.text = "defaultpassword";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent
      //color set to transperent or set your own color
    ));

    return Scaffold(
      bottomSheet: Footer1(),
      body: Center(child:Form(key:_formKey, child:SingleChildScrollView(
          child:Container(
            constraints: BoxConstraints(
                minHeight:MediaQuery.of(context).size.height
              //set minimum height equal to 100% of VH
            ),
            width:Responsive.isDesktop(context)?450:350,

            //make width of outer wrapper to 100%
            decoration:BoxDecoration(
              // gradient: LinearGradient(
              //   begin: Alignment.topRight,
              //   end: Alignment.bottomLeft,
              //   colors: [ Colors.orange,Colors.deepOrangeAccent,
              //     Colors.purple, Colors.redAccent,
              //   ],
              // ),
            ), //show linear gradient background of page

            padding: EdgeInsets.all(20),
            child:Column(children:<Widget>[

              Container(
                margin: EdgeInsets.only(top:80),
                child: Text("Login", style: TextStyle(
                    color:Colors.black,fontSize: 40, fontWeight: FontWeight.bold
                ),), //title text
              ),

              // Container(
              //   margin: EdgeInsets.only(top:10),
              //   child: Text("Sign In using UserID and Password", style: TextStyle(
              //       color:Colors.white,fontSize: 15
              //   ),), //subtitle text
              // ),



              new TextFormField(
                controller: _user_id,
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
               onChanged: (val){
                  user_id=val;
                },
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
              SizedBox(height: 20),
              new TextFormField(
                controller: _password,
                //inputFormatters: [FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),],
                onChanged: (value){
                  password=value;
                },
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

            Container(
                //show error message here
                padding: EdgeInsets.all(8.0),
                child:error? errmsg(errormsg):null,
                //if error == true then show error message
                //else set empty container as child
              ),

              SizedBox(height: 12),
              Padding( padding:EdgeInsets.symmetric(horizontal: 8,vertical: 8,),child:Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      spreadRadius: -8,
                      blurRadius: 16,
                      blurStyle: BlurStyle.normal,
                    ),
                  ],
                ),
                child:ElevatedButton(

                  child: Container(
                    width: double.infinity,
                    height: 50,
                    
                    child: showprogress?
                    LoadingJumpingLine.circle(duration: Duration(milliseconds: 1000),
                      backgroundColor: Colors.grey,
                    ):Center(child: Text("Login Now"),),),
                  onPressed: () async {

                    if(_formKey.currentState!.validate()){
                      setState(() {
                        //show progress indicator on click
                        showprogress = true;
                        _visible=true;
                      });


                      startLogin();

                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              ),

              // Container(
              //   padding: EdgeInsets.all(10),
              //   margin: EdgeInsets.only(top:20),
              //   child: SizedBox(
              //     height: 60, width: double.infinity,
              //     child:RaisedButton(
              //       onPressed: (){
              //         setState(() {
              //           //show progress indicator on click
              //           showprogress = true;
              //         });
              //         startLogin();
              //
              //       },
              //       child: showprogress?
              //       SizedBox(
              //         height:30, width:30,
              //         child: CircularProgressIndicator(
              //           backgroundColor: Colors.orange[100],
              //           valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
              //         ),
              //       ):Text("LOGIN NOW", style: TextStyle(fontSize: 20),),
              //       // if showprogress == true then show progress indicator
              //       // else show "LOGIN NOW" text
              //       colorBrightness: Brightness.dark,
              //       color: Colors.orange,
              //       shape: RoundedRectangleBorder(
              //           borderRadius:BorderRadius.circular(30)
              //         //button corner radius
              //       ),
              //     ),
              //   ),
              // ),

              Container(
                padding: EdgeInsets.all(8.0),

                child: InkWell(

                  borderRadius: BorderRadius.circular(16.0),
                    onTap:(){
                      //action on tap
                    },
                    child:Text(" Forgot Password? ",
                      style: TextStyle(color:Colors.blueGrey, fontSize:14),
                    )
                ),
              )
            ]),
          )
      ),),),
    );
  }

  InputDecoration myInputDecoration({required String label, required IconData icon})
  {
    return InputDecoration(
      hintText: label, //show label as placeholder
      hintStyle: TextStyle(color:Colors.orange[100], fontSize:20), //hint text style

      prefixIcon: Padding(
          padding: EdgeInsets.only(left:20, right:10),
          child:Icon(icon, color: Colors.orange[100],)
        //padding and icon for prefix
      ),

      contentPadding: EdgeInsets.fromLTRB(30, 20, 30, 20),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color:Colors.orange, width: 1)
      ), //default border of input

      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color:Colors.orange, width: 1)
      ), //focus border

      fillColor: Color.fromRGBO(251,140,0, 0.5),
      filled: true, //set true if you want to show input background
    );
  }

  Widget errmsg(String text){
    //error message widget.

    return Container(
      padding: EdgeInsets.all(8.0),

      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.red,
          border: Border.all(color:Colors.red, width:2)
      ),
      child: Row(children: <Widget>[
        Container(
          margin: EdgeInsets.only(right:4.00),
          child: Icon(Icons.info, color: Colors.white),
        ), // icon for error message

        Text(text, style: TextStyle(color: Colors.white, fontSize: 14)),
        //show error message text
      ]),
    );

  }
}