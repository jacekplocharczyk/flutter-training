import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:training_app/models/article.dart';
import 'package:training_app/commons/http_requests.dart';

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

// class UploadButton extends StatelessWidget {
//   const UploadButton({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.publish),
//       onPressed: () {
//         context.pushReplacement('..');
//       },
//     );
//   }
// }

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

    final article = articleList.articles[widget.articleIndex];
    final appBar = UploadArticleAppBar(article: article);
    String tmp = "Uploading";
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Text(
          tmp, // default text style
          textAlign: TextAlign.center,
          textScaleFactor: 2.0,
        ),
      ),
    );
  }
}
