import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:rueo/main.dart';
import 'package:rueo/settings.dart';
import 'package:rueo/localization.dart';
import 'package:rueo/model.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Languages? _curLang;
  late StreamSubscription<Languages> _subscription;

  _SettingsPageState() {
    _subscription = GetIt.I<Settings>()
        .langSettingStream
        .stream
        .listen((Languages newLang) {
      _curLang = newLang;
    });
    _curLang = GetIt.I<Settings>().enterSettingsScreen();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<Languages>(
            initialData: _curLang ?? Settings.defaultSettings.curLang,
            stream: GetIt.I<Settings>().langSettingStream.stream,
            builder: (_, __) {
              return Column(
                children: [
                  _head(),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        _languageSettings(),
                        _divider(),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  Widget _divider() {
    return Divider(
      height: 20.0,
      thickness: 3.0,
      color: GetIt.I<Settings>().primaryColor,
      indent: 30.0,
      endIndent: 30.0,
    );
  }

  Widget _head() {
    return Container(
      decoration: BoxDecoration(
        color: GetIt.I<Settings>().primaryColor,
      ),
      child: Padding(
        padding: EdgeInsets.zero,
        child: Row(
          children: [
            TextButton(
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 28,
              ),
              onPressed: _storeSettings,
            ),
            Spacer(),
            Text(
              GetIt.I<Settings>()
                  .retrieveMessage(Messages.settingsTitle, mainData: false),
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            Spacer(),
            TextButton(
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        ),
      ),
    );
  }

  void _storeSettings() async {
    Navigator.of(context).pop();
    await GetIt.I<Settings>().storeSettings();
  }

  Widget _languageSettings() {
    return Column(
      children: [
        SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Lango / Язык / Language",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        SizedBox(height: 10),
        _languageRadio("Esperanto", "assets/eo.svg", Languages.eo, (_) {
          GetIt.I<Settings>().settingLang(Languages.eo);
        }),
        _languageRadio("Русский", "assets/ru.svg", Languages.ru, (_) {
          GetIt.I<Settings>().settingLang(Languages.ru);
        }),
        _languageRadio("English", "assets/usuk.svg", Languages.en, (_) {
          GetIt.I<Settings>().settingLang(Languages.en);
        }),
      ],
    );
  }

  Widget _languageRadio(String labelText, String flagFile, Languages lang,
      void Function(Languages? lang) func) {
    return Row(
      children: [
        Radio(
          visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity),
          value: lang,
          groupValue: _curLang,
          onChanged: func,
        ),
        SizedBox(width: 5),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 15,
            maxWidth: 20,
          ),
          child: SvgPicture.asset(flagFile,
              height: 15, width: 20, fit: BoxFit.fill),
        ),
        SizedBox(width: 8.0),
        Text(labelText, style: TextStyle(fontSize: 16)),
      ],
    );
  }
}
