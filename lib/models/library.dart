import 'package:flutter/foundation.dart';

class ArticleModel {
  final String title;
  String status;
  String textContent;
  int index;

  ArticleModel(
      {required this.title,
      required this.status,
      required this.textContent,
      required this.index});
}

class ArticleListModel extends ChangeNotifier {
  List<ArticleModel> articles = [
    ArticleModel(
        title: "test title",
        status: "running",
        textContent: "some test content",
        index: 0)
  ];

  void addArticle(String title, String status, String textContent) {
    int newIndex = articles.length;
    var newArticle = ArticleModel(
        title: title,
        status: status,
        textContent: textContent,
        index: newIndex);
    articles.add(newArticle);
  }
}
