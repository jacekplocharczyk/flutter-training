import 'package:flutter/material.dart';
import 'package:training_app/models/library.dart';
import 'package:provider/provider.dart';

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
        floatingActionButton: const AddArticleButton());
  }
}

class AddArticleButton extends StatelessWidget {
  const AddArticleButton({super.key});

  @override
  Widget build(BuildContext context) {
    var articleList = Provider.of<ArticleListModel>(context);

    return FloatingActionButton(
      onPressed: () => articleList.addArticle(
          "hello amam", "your status", "your text contents"),
      child: const Icon(Icons.add),
    );
  }
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArticleListModel(),
      child: Consumer<ArticleListModel>(
        builder: (context, articleList, child) =>
            MyLibrary(articleList: articleList),
      ),
    );
  }
}
