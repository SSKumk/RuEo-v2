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
  final primaryColor = Color(0xFF548134);
  final colorForHints = Color(0x13548134);

  final String url = 'https://old.rueo.ru/sercxo/';

  late SharedPreferences _prefs;

  static final SettingsPack _defaultSettings = SettingsPack(Languages.eo);
  late SettingsPack _curSettings;

  static const String _langData = "lang";
  StreamController<Languages> langStream =
      StreamController<Languages>.broadcast();

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

    if (temp == null || lang == null) {
      lang = _defaultSettings.curLang;
      await prefs.setString(_langData, EnumToString.convertToString(lang));
    }

    SettingsPack settingsPack = SettingsPack(lang);

    Settings settings = Settings._create(prefs, settingsPack);

    return settings;
  }
}

Settings? settings;
