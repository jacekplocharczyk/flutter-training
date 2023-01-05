import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:training_app/models/article.dart';
import 'package:training_app/commons/http_requests.dart' as http_requests;

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        var currentLocation = GoRouterState.of(context).location;
        var parentLocation = currentLocation.replaceAll("/upload", "");
        // context.go(parentLocation);
        context.pushReplacement(parentLocation);
      },
    );
  }
}

class UploadArticleAppBar extends StatefulWidget with PreferredSizeWidget {
  final ArticleModel article;
  const UploadArticleAppBar({Key? key, required this.article})
      : super(key: key);

  @override
  State<UploadArticleAppBar> createState() => _UploadArticleAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _UploadArticleAppBarState extends State<UploadArticleAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.article.title),
      leading: const GoBackButton(),
      // actions: const [UploadButton()],
    );
  }
}

class UploadArticlePage extends StatefulWidget {
  final int articleIndex;
  const UploadArticlePage({super.key, required this.articleIndex});

  @override
  State<UploadArticlePage> createState() => _UploadArticlePageState();
}

class _UploadArticlePageState extends State<UploadArticlePage> {
  @override
  Widget build(BuildContext context) {
    final articleList = Provider.of<ArticleListModel>(context);

    final article = articleList.getItems()[widget.articleIndex];

    final body = FutureBuilder<String?>(
      future: http_requests.scheduleGeneratingAudio(article.textContent),
      builder: (context, snapshot) {
        var hash = snapshot.data;
        if (snapshot.connectionState == ConnectionState.done) {
          articleList.updateStatusAfterScheduling(widget.articleIndex, hash);
          return Text("Generating scheduled: ${article.articleHash}");
        } else {
          return const CircularProgressIndicator();
        }
      },
    );

    final appBar = UploadArticleAppBar(article: article);
    String text = "Uploading";
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              textScaleFactor: 2.0,
            ),
            body
          ],
        ),
      ),
    );
  }
}
