import 'package:flutter/material.dart';

import 'package:rueo/model.dart';

import 'article_widget.dart';
import 'main.dart';

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
      stream: model.hintsStream.stream,
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
            return const Text('Eraro dum prenado de sugestoj!');
          } else if (snapshot.hasData) {
            return Expanded(
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
                            child: Container(
                              height: 25,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: colorForHints,
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
                            onTap: (() {
                              model.trySearch(word);
                            }),
                          ),
                        ))
                    .toList(),
              ),
            );
          } else {
            return const Text("Ne estas sugestoj!");
          }
        } else {
          return Text('Stato: ${snapshot.connectionState}');
        }
      },
    );
  }
}
