import 'package:flutter/material.dart';

import '../utilities/constants.dart';

PreferredSizeWidget CommonAppBar() {
  return AppBar(
    backgroundColor: secondaryColor1,
    title: Align(
      alignment: Alignment.topLeft,
      child: Text(
        'Gun License Exemption Certificate - Kodagu ',
        style: TextStyle(color: textColor),
      ),
    ),
    actions: [
      CircleAvatar(),
    ],
  );
}
