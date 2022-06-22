import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rueo/localization.dart';

import 'package:rueo/settings.dart';

class Settings {
  final primaryColor = Color(0xFF548134);
  final colorForHints = Color(0x13548134);

  final String url = 'https://old.rueo.ru/sercxo/';

  Languages _curLang = Languages.eo;
  StreamController<Languages> langStream =
      StreamController<Languages>.broadcast();

  Settings() {
    langStream.add(_curLang);
  }
}

Settings settings = Settings();
