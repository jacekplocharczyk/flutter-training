import 'package:flutter/material.dart';
import 'package:training_app/models/library.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class LibraryRow extends StatefulWidget {
  final ArticleModel article;
  const LibraryRow({Key? key, required this.article}) : super(key: key);

  @override
  State<LibraryRow> createState() => _LibraryRowState();
}

class _LibraryRowState extends State<LibraryRow> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(widget.article.title),
      const Spacer(),
      Text(widget.article.status),
    ]);
  }
}

class AddArticleButton extends StatelessWidget {
  const AddArticleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        context.pushReplacement('/add');
      },
      child: const Icon(Icons.add),
    );
  }
}

class LibraryBody extends StatefulWidget {
  final ArticleListModel articleList;
  const LibraryBody({Key? key, required this.articleList}) : super(key: key);

  @override
  State<LibraryBody> createState() => _LibraryBodyState();
}

class _LibraryBodyState extends State<LibraryBody> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.articleList.articles.length,
      itemBuilder: (context, index) {
        return LibraryRow(article: widget.articleList.articles[index]);
      },
    );
  }
}

class LibraryScaffold extends StatelessWidget {
  const LibraryScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Catalosssg')),
        body: LibraryBody(articleList: Provider.of<ArticleListModel>(context)),
        floatingActionButton: const AddArticleButton());
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
        builder: (context, articleList, child) => const LibraryScaffold(),
      ),
    );
  }
}
