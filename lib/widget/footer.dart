import 'dart:io';

import 'package:admin/utilities/constants.dart';
import 'package:admin/utilities/responsive.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:footer/footer.dart';
class Footer1 extends StatelessWidget {
  const Footer1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String nl='';
    Responsive.isMobile(context)?nl='\n':'';
    return Container(height:120,
decoration:  BoxDecoration(  boxShadow: [
        BoxShadow(
        color: Colors.grey.withOpacity(0.8),
    spreadRadius: 8,
    blurRadius: 18,
    offset: Offset(0, 2), // changes position of shadow
    ),
    ],),
    child:Container(

      decoration:BoxDecoration(

        borderRadius: BorderRadius.only(topRight: Radius.circular(12.0),topLeft: Radius.circular(12.0)),
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [ Colors.blueGrey,Colors.white24,
            Colors.white60, Colors.white,
          ],
        ),
      ),
      child:Row(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      children:<Widget>[
        Image.asset("assets/images/nic_logo.png",width: MediaQuery.of(context).size.width*0.20,height: MediaQuery.of(context).size.height*0.20,),
        VerticalDivider(
          color: Colors.black45,
          thickness: 2,
          indent: 12,
          endIndent: 12,
          width: 24,
        ),
       new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:<Widget>[

            Text('WEBSITE POLICIES  / HELP / CONTACT US  / FEEDBACK',textAlign: TextAlign.center,style: TextStyle(fontWeight:FontWeight.w700,fontSize: 12.0,color: Color(0xFF162A49)),),
            Text('© NIC State Unit Bengaluru, Karnataka, India , $nl Developed and hosted by National Informatics Centre,',textAlign: TextAlign.center,style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0, color: Color(0xFF162A49)),),
            Text('Ministry of Electronics & Information Technology, $nl Government of India',textAlign: TextAlign.center,style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0, color: Color(0xFF162A49)),),
           // Text('Copyright ©2022, All Rights Reserved.',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0, color: Color(0xFF162A49),),),

          ]
      ),

       ],

      ),),);
  }
}
// new Container(
//     height: 45.0,
//     width: 45.0,
//     child: Center(
//       child:Card(
//         elevation: 5.0,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(25.0), // half of height and width of Image
//         ),
//         child: IconButton(
//           icon: new Icon(Icons.fingerprint,size: 20.0,),
//           color: Color(0xFF162A49),
//           onPressed: () {},
//         ),
//       ),
//     )
// ),