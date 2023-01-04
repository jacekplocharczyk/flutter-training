// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:training_app/common/theme.dart';
import 'package:training_app/models/cart.dart';
import 'package:training_app/models/catalog.dart';
import 'package:training_app/screens/cart.dart';
import 'package:training_app/screens/catalog.dart';
import 'package:training_app/screens/library.dart';

void main() {
  runApp(const MyApp());
}

// GoRouter router() {
//   return GoRouter(
//     initialLocation: '/catalog',
//     routes: [
//       GoRoute(
//         path: '/catalog',
//         builder: (context, state) => const MyCatalog(),
//         routes: [
//           GoRoute(
//             path: 'cart',
//             builder: (context, state) => const MyCart(),
//           ),
//         ],
//       ),
//     ],
//   );
// }

List<Article> articleList = [
  Article("title", "status 1", "some_text_content"),
  Article("title 2", "status 2", "other some_text_content"),
  Article("title 3", "status 3", "another some_text_content"),
  Article("title 3", "status 3", "another some_text_content"),
  Article("title 3", "status 3", "another some_text_content"),
];

GoRouter router() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => MyLibrary(articleList: articleList),
        routes: [
          GoRoute(
            path: 'cart',
            builder: (context, state) => const MyCart(),
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
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        // In this sample app, CatalogModel never changes, so a simple Provider
        // is sufficient.
        Provider(create: (context) => CatalogModel()),
        // CartModel is implemented as a ChangeNotifier, which calls for the use
        // of ChangeNotifierProvider. Moreover, CartModel depends
        // on CatalogModel, so a ProxyProvider is needed.
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
          create: (context) => CartModel(),
          update: (context, catalog, cart) {
            if (cart == null) throw ArgumentError.notNull('cart');
            cart.catalog = catalog;
            return cart;
          },
        ),
      ],
      child: MaterialApp.router(
        title: 'Provider Demo',
        theme: appTheme,
        routerConfig: router(),
      ),
    );
  }
}
