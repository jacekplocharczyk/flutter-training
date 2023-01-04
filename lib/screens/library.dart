// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class ArticleModel {
  String title;
  String status;
  String textContent;

  ArticleModel(this.title, this.status, this.textContent);
}

class ArticleListModel extends ChangeNotifier {
  List<ArticleModel> articles = [];
  // ArticleListModel(this.articles);

  void addArticle(String title, String status, String textContent) {
    var newArticle = ArticleModel(title, status, textContent);

    articles.add(newArticle);
    notifyListeners();
  }
}

class LibraryItem extends StatefulWidget {
  final ArticleModel article;
  const LibraryItem({Key? key, required this.article}) : super(key: key);

  @override
  State<LibraryItem> createState() => _LibraryItemState();
}

class _LibraryItemState extends State<LibraryItem> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(widget.article.title),
      const Spacer(),
      Text(widget.article.status),
    ]);
  }
}

class MyLibrary extends StatefulWidget {
  final ArticleListModel articleList;
  const MyLibrary({Key? key, required this.articleList}) : super(key: key);

  @override
  State<MyLibrary> createState() => _MyLibraryState();
}

class _MyLibraryState extends State<MyLibrary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Catalosssg')),
      body: ListView.builder(
        itemCount: widget.articleList.articles.length,
        itemBuilder: (context, index) {
          return LibraryItem(article: widget.articleList.articles[index]);
        },
      ),
    );
  }
}
