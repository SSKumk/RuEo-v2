import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:rueo/main.dart';
import 'package:rueo/model.dart';
import 'package:rueo/settings.dart';
import 'package:rueo/localization.dart';

class HintView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HintViewState();
  }
}

class HintViewState extends State<HintView> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: GetIt.I<Model>().hintsStream.stream,
      initialData: [],
      builder: (
        BuildContext context,
        AsyncSnapshot<List<String>> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return constructWithLanguage(
              Messages.suggestionLoadError,
              (mess) => Text(
                mess,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return snapshot.data!.isEmpty
                ? constructWithLanguage(
                    Messages.noSuggestions,
                    (mess) => Text(
                      mess,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView(
                      key: ValueKey(snapshot.data),
                      padding: const EdgeInsets.all(0.0),
                      scrollDirection: Axis.vertical,
                      children: snapshot.data!
                          .map((word) => Padding(
                                padding: const EdgeInsets.only(
                                  top: 0.0,
                                  bottom: 5.0,
                                  left: 5.0,
                                  right: 3.0,
                                ),
                                child: GestureDetector(
                                  onTap: (() {
                                    GetIt.I<Model>().trySearch(word);
                                  }),
                                  child: Container(
                                    height: 25,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color:
                                              GetIt.I<Settings>().colorForHints,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      word,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  );
          } else {
            return constructWithLanguage(
                Messages.noSuggestions, (mess) => Text(mess));
          }
        } else {
          return constructWithLanguage(
              Messages.strangeStateOfSuggestionLoad, (mess) => Text(mess),
              addText: ": '${snapshot.connectionState}'");
        }
      },
    );
  }
}
