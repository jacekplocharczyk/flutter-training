import 'package:flutter/foundation.dart';
import 'package:training_app/commons/article_states.dart' as article_states;

class ArticleModel {
  final String title;
  article_states.ArticleState state;
  String textContent;
  int index;
  String? articleHash;

  ArticleModel(
      {required this.title,
      required this.state,
      required this.textContent,
      required this.index});
}

class ArticleListModel extends ChangeNotifier {
  List<ArticleModel> articles = [
    ArticleModel(
        title: "test title",
        state: article_states.ArticleState.created,
        textContent: "some test content",
        index: 0)
  ];

  void addArticle(
      String title, article_states.ArticleState state, String textContent) {
    int newIndex = articles.length;
    var newArticle = ArticleModel(
        title: title, state: state, textContent: textContent, index: newIndex);
    articles.add(newArticle);
  }
}
