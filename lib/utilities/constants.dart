import 'package:flutter/material.dart';

//colors

const primaryColorBlue = Color(0xFF2697FF);
const primaryColor = Color(0xFF212332);

const secondaryColorDark = Color(0xFF2A2D3E);
const secondaryColor = Color(0xDDDDDDDD);
const secondaryColor1 = Color(0xFFFFAB00);

const bgColorDark = Color(0xFF212332);
const bgColor = Colors.white;

const successColor = Colors.lightGreenAccent;
const hoverColorBlue = Color(0xFF3598FF);
const hoverColor = Color(0xFFFFAA00);
const textColor = Colors.black;
const tableBackground = Color(0xEEEEEEEE);
const deleteColor = Color(0xFFFF5500);
//Padding and margin
const horizontalPadding = EdgeInsets.symmetric(horizontal: 12);
const verticalPadding = EdgeInsets.symmetric(vertical: 12);
const defaultPadding = EdgeInsets.all(16.0);

const leftRightPadding = EdgeInsets.only(left: 8.0, right: 8.0);

//text size
const headingTextStyle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  shadows: [
    Shadow(
      color: Colors.black38,
      blurRadius: 2.0,
      offset: Offset(0.0, 4.0),
    ),
  ],
);

const tableHeadingTextStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w600,
  shadows: [
    Shadow(
      color: Colors.black12,
      blurRadius: 2.0,
      offset: Offset(0.0, 4.0),
    ),
  ],
);
//Button Outline blue
final outlinedButtonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(
    const EdgeInsets.all(16),
  ),
  backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
  foregroundColor: MaterialStateProperty.all<Color>(primaryColorBlue),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
      side: const BorderSide(color: primaryColorBlue),
    ),
  ),
);

//Red Circular delete button style

final redCircularButton = ButtonStyle(
  shadowColor: MaterialStateProperty.all<Color>(Colors.black),
  padding: MaterialStateProperty.all<EdgeInsets>(
    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
  ),
  backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
  foregroundColor: MaterialStateProperty.all<Color>(Colors.black87),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
      side: const BorderSide(color: Colors.black54),
    ),
  ),
);

// positive button=>white circular button ,red border .
final positiveButton = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(
    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
  ),
  foregroundColor: MaterialStateProperty.all<Color>(successColor),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
      side: const BorderSide(color: successColor),
    ),
  ),
);
//negetive button
final negetiveButton = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(
    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
  ),
  foregroundColor: MaterialStateProperty.all<Color>(deleteColor),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
      side: const BorderSide(color: deleteColor),
    ),
  ),
);

//text form decoration.
final textFormDecoration = new InputDecoration(
  labelText: "Taluk Name ",
  labelStyle: TextStyle(fontSize: 14),
  fillColor: Colors.white,

  border: new OutlineInputBorder(
    borderRadius: new BorderRadius.circular(16.0),
    borderSide: new BorderSide(color: Colors.green),
  ),
  //fillColor: Colors.green
);
