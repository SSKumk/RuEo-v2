import 'package:flutter/material.dart';

import 'package:rueo/leftBar.dart';
import 'package:rueo/rightBar.dart';
import 'package:rueo/settings.dart';
import 'package:rueo/model.dart';
import 'package:rueo/hint_widget.dart';

import 'article_widget.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();
final TextEditingController searchController = TextEditingController();

void main() async {
  settings = await Settings.create();

  runApp(
    // перезапускает приложение
    MaterialApp(
      debugShowCheckedModeBanner: false, // скрываем надпись debug
      theme: ThemeData(
        primaryColor: settings?.primaryColor,
      ),
      home: HomePage(),
    ),
  );
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static var myBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0));

  FocusNode? _myFocusNode;

  @override
  void initState() {
    super.initState();

    _myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _myFocusNode!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        drawer: LeftNavDrawer(),
        endDrawer: RDrawer(),
        body: Column(children: [
          head(),
          viewPanel(),
        ]));
  }

  Widget viewPanel() {
    return StreamBuilder<AppState>(
      stream: model.stateStream.stream,
      initialData: AppState.emptyString,
      builder: (
        BuildContext context,
        AsyncSnapshot<AppState> snapshot,
      ) {
        AppState? curState =
            snapshot.hasData ? snapshot.data : AppState.emptyString;
        switch (curState) {
          case AppState.inTyping:
            return HintView();
          case AppState.waitForTyping:
            return ArticleView();
          case AppState.emptyString:
            return Text("");
          default:
            return Text("Malbona stato!");
        }
      },
    );
  }

  Widget head() {
    return Container(
      decoration: BoxDecoration(
        color: settings?.primaryColor,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Row(
            children: [
              myIconButton(Icons.menu, () => _key.currentState!.openDrawer()),
              const SizedBox(width: 3.0, child: null),
              // myIconButton(Icons.search, () {
              //   model.trySearch(null);
              // }),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    bottom: 10.0,
                    left: 5.0,
                    right: 3.0,
                  ),
                  child: StreamBuilder<String>(
                    stream: model.typeStream.stream,
                    initialData: "",
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<String> snapshot,
                    ) {
                      searchController.text =
                          (snapshot.hasData ? snapshot.data : "")!;
                      searchController.selection = TextSelection.fromPosition(
                          TextPosition(offset: searchController.text.length));
                      return TextField(
                        controller: searchController,
                        focusNode: _myFocusNode,
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          border: myBorder,
                          enabledBorder: myBorder,
                          focusedBorder: myBorder,
                          isDense: true,
                          hintText: "Tajpu vorton",
                          hintStyle: TextStyle(color: Colors.white60),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 3.0, vertical: 3.0),
                        ),
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                        onChanged: (text) {
                          model.typeChanged(text);
                        },
                        onSubmitted: (text) {
                          model.trySearch(null);
                          _myFocusNode!.requestFocus();
                        },
                      );
                    },
                  ),
                ),
              ),
              myIconButton(Icons.clear, model.clearType),
              myIconButton(Icons.undo_rounded, () {}),
              myIconButton(Icons.find_in_page_outlined, () {}),
              myIconButton(Icons.arrow_left, () {}, width: 25.0),
              myIconButton(Icons.arrow_right, () {}, width: 25.0),
              myIconButton(
                  Icons.history, () => _key.currentState!.openEndDrawer()),
            ],
          ),
        ),
      ),
    );
  }

  Widget myIconButton(IconData icon, void Function() func,
      {double width = 30.0}) {
    return SizedBox(
      width: width,
      height: 30.0,
      child: IconButton(
        padding: const EdgeInsets.all(0.0),
        icon: Icon(
          icon,
          size: 25.0,
        ),
        color: Colors.white,
        onPressed: func,
      ),
    );
  }
}
