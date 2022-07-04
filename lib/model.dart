import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'package:rueo/settings.dart';
import 'package:rueo/localization.dart';

enum AppState { emptyString, waitForTyping, inTyping }

class Model {
// Storages
  String _curString = "";
  AppState _state = AppState.emptyString;
  List<String> _hints = [];
  String _article = "";

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// Последний довод королей
  AppState getState() => _state;

  String getCurString() => _curString;

  List<String> getHints() => _hints;

  String getArticle() => _article;

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  StreamController<String> typeStream = StreamController<String>.broadcast();
  StreamController<AppState> stateStream =
      StreamController<AppState>.broadcast();
  StreamController<List<String>> hintsStream =
      StreamController<List<String>>.broadcast();
  StreamController<String> articleStream = StreamController<String>.broadcast();

// Constructor - initializes the streams
  Model() {
    stateStream.add(_state);
    typeStream.add(_curString);
    hintsStream.add(_hints);
    articleStream.add(_article);
  }

// Setting data
  void setCurString(String newText, {bool toRebuild = false}) {
    _curString = newText;
    if (toRebuild) {
      typeStream.add(_curString);
    }
  }

  void setState(AppState newState) {
    _state = newState;
    stateStream.add(_state);
  }

  void setHints(List<String> newHints) {
    _hints = newHints;
    hintsStream.add(_hints);
  }

  void setArticle(String newArticle) {
    _article = newArticle;
    articleStream.add(_article);
  }

  void fetchHints() {
    if (_state != AppState.emptyString) {
      http
          .get(Uri.parse(GetIt.I<Settings>().url + '?ajax&term=' + _curString))
          .then(hintsGot);
    }
  }

  void fetchArticle() {
    http.get(Uri.parse(GetIt.I<Settings>().url + _curString)).then(articleGot);
  }

  FutureOr<dynamic> hintsGot(http.Response resp) {
    List<String> gotHints = List.from(
        jsonDecode(resp.body)
            .map((hint) => hint['value'] as String)
            .where((hint) => hint != ""),
        growable: false);
    if (gotHints.isEmpty) {
      gotHints = [GetIt.I<Settings>().retrieveMessage(Messages.noSuggestions)];
    }
    setHints(gotHints);
  }

  void articleGot(http.Response responce) async {
    if (responce.statusCode == 200) {
      // вырезает необходимую часть html из сайта
      int firstMatch = responce.body.indexOf('<div class="search_result">');
      String result1 = responce.body.substring(
          firstMatch + '<div class="search_result">'.length,
          responce.body.length);
      int secondMatch = result1.indexOf('<div class="search_result">');
      String tempResult = result1.substring(0, secondMatch);
      int komMatch = tempResult.indexOf('<div class="kom">');
      int endKom = tempResult.indexOf('</div>', komMatch);
      String articleWithoutKom =
          tempResult.substring(0, komMatch + '<div class="kom">'.length) +
              tempResult.substring(endKom + '</div>'.length);
      print('конец загрузки статьи: ${articleWithoutKom}');
      setState(AppState.waitForTyping);
      setArticle(articleWithoutKom);
    }
  }

  void typeChanged(String newText) {
    if (newText == _curString) {
      return;
    }

    if (newText == "") {
      setCurString("");
      setState(AppState.emptyString);
      return;
    }

    switch (_state) {
      case AppState.emptyString:
        setState(AppState.inTyping);
        setCurString(newText);
        fetchHints();
        break;

      case AppState.inTyping:
        setCurString(newText);
        fetchHints();
        break;

      case AppState.waitForTyping:
        setCurString(newText);
        setState(AppState.inTyping);
        fetchHints();
        break;
    }
  }

  void trySearch(String? text) {
    if (text != null) {
      setCurString(text, toRebuild: true);
    }

    if (_state != AppState.emptyString) {
      fetchArticle();
      setState(AppState.waitForTyping);
    }
  }

  void clearType() {
    setState(AppState.emptyString);
    setCurString("", toRebuild: true);
  }
}
