import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:training_app/commons/article_states.dart' as article_states;
import 'dart:collection';
import 'package:training_app/commons/http_requests.dart' as http_requests;
import 'package:flutter/material.dart';

class ArticleModel {
  String title;
  article_states.ArticleState state;
  String textContent;
  int index;
  String? articleHash;
  String? audioUrl;
  String? audioBytes;

  ArticleModel(
      {required this.title,
      required this.state,
      required this.textContent,
      required this.index});

  void update(
      {String? newTitle,
      article_states.ArticleState? newState,
      String? newTextContent,
      String? newArticleHash,
      String? newAudioUrl,
      String? newAudioBytes}) {
    title = newTitle ?? title;
    state = newState ?? state;
    textContent = newTextContent ?? textContent;
    articleHash = newArticleHash ?? articleHash;
    audioUrl = newAudioUrl ?? audioUrl;
    audioUrl = newAudioBytes ?? audioUrl;
  }

  void updateStatusAfterScheduling(String? hash) {
    state = hash == null
        ? article_states.ArticleState.uploadFailed
        : article_states.ArticleState.scheduled;
    articleHash = hash;
  }

  article_states.ArticleState convertStatusCodeToArticleStatus(
      Response response) {
    final article_states.ArticleState state;

    switch (response.statusCode) {
      case 200:
        state = article_states.ArticleState.completed;
        break;
      case 102:
        state = article_states.ArticleState.processing;
        break;
      default:
        state = article_states.ArticleState.processingFailed;
    }

    return state;
  }

  void checkStatusAsync() async {
    var processingResponse =
        await http_requests.checkProcessingStatus(audioUrl!);
    state = convertStatusCodeToArticleStatus(processingResponse);
    if (state == article_states.ArticleState.completed) {
      audioBytes = processingResponse.body;
    }
  }

  void checkStatus() {
    const pendingStates = [
      article_states.ArticleState.scheduled,
      article_states.ArticleState.processing
    ];
    if (pendingStates.contains(state)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        checkStatusAsync();
      });
    }
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

  void updateStatusAfterScheduling(
      int index, Map<String, String>? scheduleResult) {
    article_states.ArticleState state;
    String? hash;
    String? audioUrl;
    if (scheduleResult == null) {
      state = article_states.ArticleState.uploadFailed;
    } else {
      hash = scheduleResult["item_id"];
      audioUrl = scheduleResult["audio_url"];
      state = article_states.ArticleState.scheduled;
    }

    _articles[index]
        .update(newState: state, newArticleHash: hash, newAudioUrl: audioUrl);
  }

  void refresh() {
    for (final article in _articles) {
      print("checking article");
      article.checkStatus();
      // notifyListeners();
    }
  }
}
