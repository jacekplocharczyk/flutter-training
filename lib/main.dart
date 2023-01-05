import 'package:flutter/material.dart';
import 'package:training_app/screens/library.dart';
import 'package:training_app/models/article.dart';
import 'package:training_app/screens/welcome.dart';
import 'package:training_app/screens/add_article.dart';
import 'package:training_app/screens/view_article.dart';
import 'package:training_app/screens/upload_article.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

Widget wrapConsumer(Widget body) {
  var consumer = Consumer<ArticleListModel>(
    builder: (context, articleList, child) => body,
  );
  return consumer;
}

GoRouter router() {
  return GoRouter(
    initialLocation: '/articles/0',
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) => wrapConsumer(const WelcomePage()),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => wrapConsumer(const LibraryPage()),
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => wrapConsumer(AddArticlePage()),
          ),
          GoRoute(
            path: 'articles/:index',
            builder: (context, state) {
              var index = int.parse(state.params["index"]!);
              return wrapConsumer(ArticleViewPage(articleIndex: index));
            },
            routes: [
              GoRoute(
                name: "upload",
                path: 'upload',
                builder: (context, state) {
                  var index = int.parse(state.params["index"]!);
                  return wrapConsumer(UploadArticlePage(articleIndex: index));
                },
              )
            ],
          ),
        ],
      ),
    ],
  );
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     const appTitle = 'Training App';

//     return ChangeNotifierProvider(
//       create: (_) => ArticleListModel(),
//       child: Consumer<ArticleListModel>(
//         builder: (context, articleList, child) => MaterialApp.router(
//           title: appTitle,
//           theme: ThemeData(
//             primarySwatch: Colors.blue,
//           ),
//           routerConfig: router(),
//         ),
//       ),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Training App';

    return ChangeNotifierProvider(
      create: (_) => ArticleListModel(),
      child: MaterialApp.router(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: router(),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}
