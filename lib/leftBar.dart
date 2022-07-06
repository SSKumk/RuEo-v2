import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rueo/main.dart';

import 'package:rueo/settings.dart';
import 'package:rueo/localization.dart';
import 'package:rueo/settings_screen.dart';

// Press the Navigation Drawer button to the left of AppBar to show
class LeftDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: GetIt.I<Settings>().primaryColor,
        child: Column(
          children: [
            SizedBox(height: 10),
            SizedBox(
              height: 75.0,
              child: DrawerHeader(
                decoration:
                    BoxDecoration(color: GetIt.I<Settings>().primaryColor),
                margin: EdgeInsets.all(0.0),
                padding: EdgeInsets.all(0.0),
                child: Expanded(
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Image.asset("assets/esperanto_star.png", width: 48),
                      SizedBox(width: 10),
                      Text("RuEo",
                          style: TextStyle(color: Colors.white, fontSize: 24)),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 11),
            Divider(
              height: 5.0,
              thickness: 3.0,
              color: Colors.white,
              indent: 10.0,
              endIndent: 10.0,
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  constructItem(
                      Messages.mailAboutVocabulary, Icons.mail, () {}),
                  constructItem(Messages.mailAboutApp, Icons.mail, () {}),
                  constructItem(Messages.settings, Icons.settings, () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => SettingsPage()),
                    );
                  }),
                  constructItem(Messages.help, Icons.help, () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget constructItem(
    Messages messType, IconData icon, void Function() tapProcessor) {
  return Container(
    height: 35.0,
    child: constructWithLanguage(
      messType,
      (mess) => ListTile(
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        minLeadingWidth: 10,
        title:
            Text(mess, style: TextStyle(fontSize: 18.0, color: Colors.white)),
        onTap: tapProcessor,
      ),
    ),
  );
}
