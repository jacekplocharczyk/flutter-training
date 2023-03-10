import 'package:flutter/material.dart';
import 'package:training_app/models/article.dart';
import 'package:training_app/commons/article_states.dart' as article_states;
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
    final articleStateText =
        article_states.articleStateMap[widget.article.state];

    final int index = widget.article.index;
    return GestureDetector(
      onTap: () {
        context.go("/articles/$index");
      },
      child: Row(
        children: [
          Text(widget.article.title),
          const Spacer(),
          Text(articleStateText!),
        ],
      ),
    );
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
    widget.articleList.refresh();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
      child: ListView.builder(
        itemCount: widget.articleList.getItems().length,
        itemBuilder: (context, index) {
          return LibraryRow(article: widget.articleList.getItems()[index]);
        },
      ),
    );
  }
}

class LibraryScaffold extends StatelessWidget {
  const LibraryScaffold({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Your articles')),
        body: LibraryBody(articleList: Provider.of<ArticleListModel>(context)),
        floatingActionButton: const AddArticleButton());
  }
}

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const LibraryScaffold();
  }
}
