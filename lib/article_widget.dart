import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get_it/get_it.dart';
import 'package:rueo/main.dart';

import 'package:rueo/model.dart';
import 'package:rueo/settings.dart';
import 'package:rueo/localization.dart';

class ArticleView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ArticleViewState();
  }
}

class ArticleViewState extends State<ArticleView> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: GetIt.I<Model>().articleStream.stream,
      initialData: '',
      builder: (
        BuildContext context,
        AsyncSnapshot<String> snapshot,
      ) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return constructWithLanguage(
                Messages.articleLoadError, (mess) => Text(mess));
          } else if (snapshot.hasData) {
            return Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Html(
                  data: snapshot.data,
                  defaultTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                  padding: const EdgeInsets.all(8.0),
                ),
              ),
            );
          } else {
            return constructWithLanguage(
                Messages.noArticle, (mess) => Text(mess));
          }
        } else {
          return constructWithLanguage(
              Messages.strangeStateOfArticleLoad, (mess) => Text(mess),
              addText: ": ${snapshot.connectionState}");
        }
      },
    );
  }
}
