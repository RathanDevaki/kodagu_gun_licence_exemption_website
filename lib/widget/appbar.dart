import 'package:flutter/material.dart';

import '../utilities/constants.dart';

PreferredSizeWidget CommonAppBar() {
  return AppBar(
    backgroundColor: secondaryColor1,
    title: Align(
      alignment: Alignment.topLeft,
      child: Text(
        'Gun License Exemption Certificate Kodagu ',
        style: headingTextStyle,
      ),
    ),
    actions: [
      Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              offset: const Offset(
                1.5,
                1.0,
              ),
              blurRadius: 24.0,
              spreadRadius: 4.0,
            ), //BoxShadow
          ],
        ),
        child: CircleAvatar(
          child: Image.asset(
            'assets/images/user.png',
            fit: BoxFit.cover,
          ),
        ),
      ),
    ],
  );
}
