// выдвижное меню слева
import 'package:flutter/material.dart';

// Press the Navigation Drawer button to the left of AppBar to show
class LeftNavDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF64DD17),
              ),
              child: Text(
                'Меню',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('письмо автору словаря'),
              hoverColor: Colors.white60,
              // onTap: () {
              //   // change app state...
              //   //Navigator.pop(context); // close the drawer
              // },
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('письмо автору приложения'),
              hoverColor: Colors.white60,
              // onTap: () {
              //   // change app state...
              //   //Navigator.pop(context); // close the drawer
              // },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              hoverColor: Colors.white60,
              // onTap: () {
              //   // change app state...
              //   //Navigator.pop(context); // close the drawer
              // },
            ),
          ],
        ),
      );
  }
/*ListTile(
  leading: Icon(Icons.change_history),
  title: Text('Change history'),
  onTap: () {
    // change app state...
    Navigator.pop(context); // close the drawer
    },
   );*/
}

