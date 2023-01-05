import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:training_app/models/article.dart';
import 'package:training_app/commons/http_requests.dart';

// body: Center(
//           child: FutureBuilder<Album>(
//             future: futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Text(snapshot.data!.title);
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }

//               // By default, show a loading spinner.
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),

class GoBackButton extends StatelessWidget {
  const GoBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        context.pushReplacement('/');
      },
    );
  }
}

class UploadButton extends StatelessWidget {
  const UploadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.publish),
      onPressed: () {
        String currentLocation = GoRouterState.of(context).location;
        var uploadLocation = "$currentLocation/upload";
        context.go(uploadLocation);
      },
    );
  }
}

class ViewArticleAppBar extends StatefulWidget with PreferredSizeWidget {
  final ArticleModel article;
  const ViewArticleAppBar({Key? key, required this.article}) : super(key: key);

  @override
  State<ViewArticleAppBar> createState() => _ViewArticleAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ViewArticleAppBarState extends State<ViewArticleAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.article.title),
      leading: const GoBackButton(),
      actions: const [UploadButton()],
    );
  }
}

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
    final appBar = ViewArticleAppBar(article: article);

    return Scaffold(
      appBar: appBar,
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
