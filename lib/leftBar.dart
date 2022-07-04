import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:rueo/main.dart';

import 'package:rueo/model.dart';
import 'package:rueo/settings.dart';
import 'package:rueo/localization.dart';

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
                      Image.asset("asset/esperanto_star.png", width: 48),
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 35.0,
                      child: constructWithLanguage(
                        Messages.mailAboutVocabulary,
                        (mess) => ListTile(
                          leading: Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          minLeadingWidth: 10,
                          title: Text(mess,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white)),
                        ),
                      ),
                    ),
                    Container(
                      height: 35.0,
                      child: constructWithLanguage(
                        Messages.mailAboutApp,
                        (mess) => ListTile(
                          leading: Icon(
                            Icons.mail,
                            color: Colors.white,
                          ),
                          minLeadingWidth: 10,
                          title: Text(mess,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white)),
                        ),
                      ),
                    ),
                    Container(
                      height: 35.0,
                      child: constructWithLanguage(
                        Messages.settings,
                        (mess) => ListTile(
                          leading: Icon(
                            Icons.settings,
                            color: Colors.white,
                          ),
                          minLeadingWidth: 10,
                          title: Text(mess,
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
