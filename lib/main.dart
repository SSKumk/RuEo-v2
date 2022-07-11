import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import 'package:rueo/leftBar.dart';
import 'package:rueo/rightBar.dart';
import 'package:rueo/settings.dart';
import 'package:rueo/localization.dart';
import 'package:rueo/model.dart';
import 'package:rueo/hint_widget.dart';
import 'package:rueo/article_widget.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();
final TextEditingController searchController = TextEditingController();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Settings settings = await Settings.create();
  GetIt.I.registerSingleton<Settings>(settings);

  Model model = Model();
  GetIt.I.registerSingleton<Model>(model);

  runApp(
    // перезапускает приложение
    MaterialApp(
      debugShowCheckedModeBanner: false, // скрываем надпись debug
      theme: ThemeData(
        primaryColor: GetIt.I<Settings>().primaryColor,
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
        drawer: LeftDrawer(),
        endDrawer: RightDrawer(),
        body: Column(children: [
          head(),
          viewPanel(),
        ]));
  }

  Widget viewPanel() {
    return StreamBuilder<AppState>(
      stream: GetIt.I<Model>().stateStream.stream,
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
            return constructWithLanguage(
                Messages.badState, (mess) => Text(mess));
        }
      },
    );
  }

  Widget head() {
    return Container(
      decoration: BoxDecoration(
        color: GetIt.I<Settings>().primaryColor,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Row(
            children: [
              myIconButton(Icons.menu, () => _key.currentState!.openDrawer()),
              const SizedBox(width: 3.0, child: null),
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
                    stream: GetIt.I<Model>().typeStream.stream,
                    initialData: "",
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<String> snapshot,
                    ) {
                      searchController.text =
                          (snapshot.hasData ? snapshot.data : "")!;
                      searchController.selection = TextSelection.fromPosition(
                          TextPosition(offset: searchController.text.length));
                      return constructWithLanguage(
                          Messages.typeInvitation,
                          (mess) => TextField(
                                controller: searchController,
                                focusNode: _myFocusNode,
                                textInputAction: TextInputAction.search,
                                decoration: InputDecoration(
                                  border: myBorder,
                                  enabledBorder: myBorder,
                                  focusedBorder: myBorder,
                                  isDense: true,
                                  hintText: mess,
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
                                  GetIt.I<Model>().typeChanged(text);
                                },
                                onSubmitted: (text) {
                                  GetIt.I<Model>().trySearch(null);
                                  _myFocusNode!.requestFocus();
                                },
                              ));
                    },
                  ),
                ),
              ),
              myIconButton(Icons.clear, GetIt.I<Model>().clearType),
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

Widget constructWithLanguage(
    Messages messType, Widget Function(String mess) func,
    {String addText = ""}) {
  return StreamBuilder<Languages>(
      stream: GetIt.I<Settings>().langStream.stream,
      initialData: Settings.defaultSettings.curLang,
      builder: (_, __) {
        return func(GetIt.I<Settings>().retrieveMessage(messType) + addText);
      });
}
