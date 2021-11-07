import 'package:admin/constants.dart';
import 'package:admin/screens/custom_textbox.dart';
import 'package:admin/widget/data_table.dart';
import 'package:admin/widget/home_screen.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double sizedBoxHeight = MediaQuery.of(context).size.height * 0.020;
    return Drawer(
      child: Material(
        color: bgColor,
        child: ListView(
          padding: horizontalPadding,
          children: <Widget>[
            DrawerHeader(
              child: Image.asset("assets/images/logo.png"),
            ),
            SizedBox(height: sizedBoxHeight),
            buildMenuItem(
              text: 'Taluk',
              icon: Icons.place_outlined,
              onClicked: () => selectedItem(context, 0),
            ),
            SizedBox(height: sizedBoxHeight),
            buildMenuItem(
              text: 'Hobli',
              icon: Icons.nature_outlined,
              onClicked: () => selectedItem(context, 1),
            ),
            SizedBox(height: sizedBoxHeight),
            buildMenuItem(
              text: 'VA Circle',
              icon: Icons.account_tree,
              onClicked: () => selectedItem(context, 2),
            ),
            SizedBox(height: sizedBoxHeight),
            buildMenuItem(
              text: 'Village',
              icon: Icons.villa_outlined,
              onClicked: () => selectedItem(context, 3),
            ),
            SizedBox(height: sizedBoxHeight),
            buildMenuItem(
              text: 'Profile',
              icon: Icons.person,
            ),
            SizedBox(height: sizedBoxHeight),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings,
            ),
            SizedBox(height: sizedBoxHeight),
            Divider(
              color: secondaryColorDark,
            ),
          ],
        ),
      ),
    );
  }

  buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    // final color = secondaryColor;
    return ListTile(
      leading: Icon(icon, color: primaryColor),
      title: Text(text, style: TextStyle(color: textColor)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  selectedItem(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DataTableDB(),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 3:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => NewTextBox()),
        );
    }
  }
}
