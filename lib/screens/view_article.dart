import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:training_app/models/library.dart';

class ArticleViewPage extends StatefulWidget {
  final int articleIndex;
  const ArticleViewPage({super.key, required this.articleIndex});

  @override
  State<ArticleViewPage> createState() => _ArticleViewPageState();
}

class _ArticleViewPageState extends State<ArticleViewPage> {
  @override
  Widget build(BuildContext context) {
    final articleList = Provider.of<ArticleListModel>(context);

    final article = articleList.articles[widget.articleIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pushReplacement('/');
          },
        ),
      ),
      body: Center(
        child: Text(
          article.textContent, // default text style
          textAlign: TextAlign.center,
          textScaleFactor: 2.0,
        ),
      ),
    );
  }
}
