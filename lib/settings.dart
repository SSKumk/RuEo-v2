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
  Color primaryColor = Color(0xFF548134);
  Color colorForHints = Color(0x13548134);

  String url = 'https://old.rueo.ru/sercxo/';

  late SharedPreferences _prefs;

  static final SettingsPack defaultSettings = SettingsPack(Languages.eo);

  late SettingsPack _curSettings;
  late SettingsPack _tempSettings;

  SettingsPack _copyCurSettings() {
    return SettingsPack(_curSettings.curLang);
  }

  static const String _langData = "lang";
  StreamController<Languages> langStream =
      StreamController<Languages>.broadcast();

  Future<void> setLang(Languages newLang) async {
    if (newLang != _curSettings.curLang) {
      _curSettings.curLang = newLang;
      await _prefs.setString(_langData, EnumToString.convertToString(newLang));
      langStream.add(newLang);
    }
  }

  Settings._create(SharedPreferences prefs, SettingsPack curSettings) {
    _prefs = prefs;
    _curSettings = curSettings;
    _tempSettings = _curSettings;

    langStream.add(_curSettings.curLang);
  }

  static Future<Settings> create() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? temp;

    temp = prefs.getString(_langData);
    Languages? lang =
        temp == null ? null : EnumToString.fromString(Languages.values, temp);

    if (temp == null || lang == null) {
      lang = Settings.defaultSettings.curLang;
      await prefs.setString(_langData, EnumToString.convertToString(lang));
    }

    SettingsPack settingsPack = SettingsPack(lang);

    Settings settings = Settings._create(prefs, settingsPack);

    return settings;
  }

  String retrieveMessage(Messages message, {bool mainData = true}) {
    return messages[mainData ? _curSettings.curLang : _tempSettings.curLang]![
        message]!;
  }

  //-----------------------------------------
  // Fields and methods for working with settings screen
  StreamController<Languages> langSettingStream =
      StreamController<Languages>.broadcast();

  void settingLang(Languages? newLang) {
    _tempSettings.curLang = newLang ?? defaultSettings.curLang;
    langSettingStream.add(_tempSettings.curLang);
  }

  Languages enterSettingsScreen() {
    _tempSettings = _copyCurSettings();

    langSettingStream.add(_tempSettings.curLang);

    return _tempSettings.curLang;
  }

  Future<void> storeSettings() async {
    await setLang(_tempSettings.curLang);
  }
}
