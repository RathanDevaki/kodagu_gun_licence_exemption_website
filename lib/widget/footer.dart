import 'package:admin/utilities/constants.dart';
import 'package:flutter/material.dart';
class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight:Radius.circular(16) ),
          color:tableBackground,
          boxShadow: [BoxShadow(
            color: Colors.black45,
            blurRadius: 8.0,
          ),]
      ),
    width: MediaQuery.of(context).size.width,
    height: 100,
    //color: tableBackground,
      child: Row(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("assets/images/nic_logo.png",width: MediaQuery.of(context).size.width*0.25,height: MediaQuery.of(context).size.height*0.25,),
           VerticalDivider(
            color: Colors.black45,
            thickness: 2,
            indent: 12,
            endIndent: 12,
            width: 20,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText('WEBSITE POLICIES  / HELP  CONTACT US  /FEEDBACK',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
            SelectableText('© NIC State Unit Bengaluru, Karnataka, India , Developed and hosted by National Informatics Centre,',style: TextStyle(fontSize: 12),),
            SelectableText('Ministry of Electronics & Information Technology, Government of India',style: TextStyle(fontSize: 12),)
          ],)

        ],
      ),
    );
  }
}
