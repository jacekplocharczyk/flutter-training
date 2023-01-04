import 'package:flutter/material.dart';
import 'package:training_app/screens/library.dart';
import 'package:training_app/screens/welcome.dart';
import 'package:training_app/screens/new_article.dart';
import 'package:go_router/go_router.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: '/welcome',
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomePage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const LibraryPage(),
        routes: [
          GoRoute(
            path: 'add',
            builder: (context, state) => const MyCustomForm(),
          ),
        ],
      ),
    ],
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Training App';

    return MaterialApp.router(
        title: appTitle,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: router());
  }
}

void main() {
  runApp(const MyApp());
}
