import 'package:flutter/foundation.dart';
import 'package:training_app/commons/article_states.dart' as article_states;
import 'dart:collection';

class ArticleModel {
  String title;
  article_states.ArticleState state;
  String textContent;
  int index;
  String? articleHash;

  ArticleModel(
      {required this.title,
      required this.state,
      required this.textContent,
      required this.index});

  void update(
      {String? newTitle,
      article_states.ArticleState? newState,
      String? newTextContent,
      String? newArticleHash}) {
    title = newTitle ?? title;
    state = newState ?? state;
    textContent = newTextContent ?? textContent;
    articleHash = newArticleHash ?? articleHash;
  }

  void updateStatusAfterScheduling(String? hash) {
    state = hash == null
        ? article_states.ArticleState.uploadFailed
        : article_states.ArticleState.scheduled;
    articleHash = hash;
  }
}

class ArticleListModel extends ChangeNotifier {
  final List<ArticleModel> _articles = [
    ArticleModel(
        title: "test title",
        state: article_states.ArticleState.created,
        textContent: "some test content",
        index: 0)
  ];
  List<ArticleModel> getItems() => UnmodifiableListView(_articles);

  void addArticle(
      String title, article_states.ArticleState state, String textContent) {
    int newIndex = _articles.length;
    var newArticle = ArticleModel(
        title: title, state: state, textContent: textContent, index: newIndex);
    _articles.add(newArticle);
    notifyListeners();
  }

  void updateStatusAfterScheduling(int index, String? hash) {
    final state = hash == null
        ? article_states.ArticleState.uploadFailed
        : article_states.ArticleState.scheduled;
    _articles[index].update(newState: state, newArticleHash: hash);
  }
}
