import 'package:flutter/foundation.dart';

class ArticleModel {
  final String title;
  String status;
  String textContent;

  ArticleModel(this.title, this.status, this.textContent);
}

class ArticleListModel extends ChangeNotifier {
  List<ArticleModel> articles = [];

  void addArticle(String title, String status, String textContent) {
    var newArticle = ArticleModel(title, status, textContent);
    articles.add(newArticle);
  }
}
