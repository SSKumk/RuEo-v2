// выдвижное меню справа

import 'package:flutter/material.dart';

class RightDrawer extends StatefulWidget {
  RightDrawer({Key? key}) : super(key: key);

  @override
  RightDrawerState createState() => RightDrawerState();
}

// Press the Navigation Drawer button to the left of AppBar to show
class RightDrawerState extends State<RightDrawer> {
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
          //onTap: () => selectedItem(context, 0),
        ),
        ListTile(
          leading: Icon(Icons.message),
          title: Text('письмо автору приложения'),
          hoverColor: Colors.white60,
          //onTap: () {},
        ),
        SizedBox(
          height: 20,
        ),
        Divider(
          color: Color(0xFF64DD17),
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
          hoverColor: Colors.white60,
          //onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Size'),

          hoverColor: Colors.white60,
          //onTap: () {},
        ),
        // Slider(
        //   min: -2,
        //   max: 2,
        //   value: rating,
        //   label: rating.round().toString(),
        //   onChanged: (value) {
        //     setState(() {
        //       rating = value;
        //     });
        //   },
        //   divisions: 5,
        // ),
      ],
    ));
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int i) {
    switch (i) {
      case 0: // каждый пункт в меню имеет индивидуальный номер
        //Navigator.of(context).push(MaterialPageRoute(builder: (context) => emailPage())); // переход на необходимую страницу
        break;
    }
  }
}
