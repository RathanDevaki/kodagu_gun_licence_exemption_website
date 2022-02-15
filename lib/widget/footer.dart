import 'package:admin/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:footer/footer.dart';
class Footer1 extends StatelessWidget {
  const Footer1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height:120,
    child:Footer(
      child: new Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:<Widget>[
            new Center(
              child:new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[

                ],
              ),
            ),
            Text('WEBSITE POLICIES  / HELP  CONTACT US  /FEEDBACK',style: TextStyle(fontWeight:FontWeight.w700, fontSize: 12.0,color: Color(0xFF162A49)),),
            Text('© NIC State Unit Bengaluru, Karnataka, India , Developed and hosted by National Informatics Centre,',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0, color: Color(0xFF162A49)),),
            Text('Ministry of Electronics & Information Technology, Government of India',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0, color: Color(0xFF162A49)),),
            Text('Copyright ©2020, All Rights Reserved.',style: TextStyle(fontWeight:FontWeight.w300, fontSize: 12.0, color: Color(0xFF162A49)),),

          ]
      ),
      padding: EdgeInsets.all(5.0),

    ),);
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