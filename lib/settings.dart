import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:enum_to_string/enum_to_string.dart';

import 'package:rueo/localization.dart';

class SettingsPack {
  late Languages curLang;

  SettingsPack(Languages lang) {
    curLang = lang;
  }
}

class Settings {
  static final Color primaryColor = Color(0xFF548134);
  static final Color colorForHints = Color(0x13548134);

  static final String url = 'https://old.rueo.ru/sercxo/';

  late SharedPreferences _prefs;

  static final SettingsPack defaultSettings = SettingsPack(Languages.en);

  late SettingsPack _curSettings;

  static const String _langData = "lang";
  StreamController<Languages> langStream =
      StreamController<Languages>.broadcast();
  void setLang(Languages newLang) async {
    if (newLang != _curSettings.curLang) {
      _curSettings.curLang = newLang;
      await _prefs.setString(_langData, EnumToString.convertToString(newLang));
      langStream.add(newLang);
    }
  }

  Settings._create(SharedPreferences prefs, SettingsPack curSettings) {
    _prefs = prefs;
    _curSettings = curSettings;

    langStream.add(_curSettings.curLang);
  }

  static Future<Settings> create() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? temp;

    temp = prefs.getString(_langData);
    Languages? lang =
        temp == null ? null : EnumToString.fromString(Languages.values, temp);

    lang = Languages.en; // !!!!!!!!!!!!!

    if (temp == null || lang == null) {
      lang = Settings.defaultSettings.curLang;
      await prefs.setString(_langData, EnumToString.convertToString(lang));
    }

    SettingsPack settingsPack = SettingsPack(lang);

    Settings settings = Settings._create(prefs, settingsPack);

    return settings;
  }

  String retrieveMessage(Messages message) {
    // print(
    //     "Retrieving message '${message}', current language - '${_curSettings.curLang}'");
    return messages[_curSettings.curLang]![message]!;
  }
}
