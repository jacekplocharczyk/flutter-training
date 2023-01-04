// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:training_app/models/cart.dart';
import 'package:training_app/models/catalog.dart';

// class ArticleModel extends ChangeNotifier {
//   String title;
//   String status;
//   String textContent;

//   ArticleModel(this.title, this.status, this.textContent);

//   void rename(String newTitle) {
//     title = newTitle;
//     notifyListeners();
//   }

//   void updateStatus(String newStatus) {
//     status = newStatus;
//     notifyListeners();
//   }

//   void updateTextContent(String newTextContent) {
//     textContent = newTextContent;
//     notifyListeners();
//   }
// }
class ArticleModel {
  String title;
  String status;
  String textContent;

  ArticleModel(this.title, this.status, this.textContent);
}
// class Article extends StatelessWidget {
//   const Article({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return

//   }
// }

class ArticleListModel extends ChangeNotifier {
  List<ArticleModel> articles = [];
  // ArticleListModel(this.articles);

  void addArticle(String title, String status, String textContent) {
    var newArticle = ArticleModel(title, status, textContent);

    articles.add(newArticle);
    notifyListeners();
  }
}

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
      // style: Theme.of(context).textThem÷e.displayLarge),
      const Spacer(),
      Text(widget.article.status),
      // style: Theme.of(context).textTheme.displayLarge)
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
    );
  }
}


//   Widget build2(BuildContext context) {
//     // backing data
//     return ListView.builder(
//       itemCount: articles.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(articles[index].title),
//         );
// }



// class BodyView extends StatelessWidget {
//   const BodyView({super.key});

//   final List<_Article> _articles = [
//     _Article("News", "In progress", "Some news text")
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return _MyListView(_articles);
//   }
// }

// class _MyListView extends StatefulWidget {
//   final List<_Article> articles;

//   const _MyListView({Key? key, required this.articles}) : super(key: key);

//   @override
//   State<_MyListView> createState() => _MyListViewState();
// }

// class _MyListViewState extends State<_MyListView> {
//   List<_Article> articles = [];

//   @override
//   Widget build(BuildContext context) {
//     // backing data
//     return ListView.builder(
//       itemCount: articles.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(articles[index].title),
//         );
//       },
//     );
//   }
// }

// class _AddButton extends StatelessWidget {
//   final Item item;

//   const _AddButton({required this.item});

//   @override
//   Widget build(BuildContext context) {
//     // The context.select() method will let you listen to changes to
//     // a *part* of a model. You define a function that "selects" (i.e. returns)
//     // the part you're interested in, and the provider package will not rebuild
//     // this widget unless that particular part of the model changes.
//     //
//     // This can lead to significant performance improvements.
//     var isInCart = context.select<CartModel, bool>(
//       // Here, we are only interested whether [item] is inside the cart.
//       (cart) => cart.items.contains(item),
//     );

//     return TextButton(
//       onPressed: isInCart
//           ? null
//           : () {
//               // If the item is not in cart, we let the user add it.
//               // We are using context.read() here because the callback
//               // is executed whenever the user taps the button. In other
//               // words, it is executed outside the build method.
//               var cart = context.read<CartModel>();
//               cart.add(item);
//             },
//       style: ButtonStyle(
//         overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
//           if (states.contains(MaterialState.pressed)) {
//             return Theme.of(context).primaryColor;
//           }
//           return null; // Defer to the widget's default.
//         }),
//       ),
//       child: isInCart
//           ? const Icon(Icons.check, semanticLabel: 'ADDED')
//           : const Text('ADD'),
//     );
//   }
// }

// class _MyAppBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       title: Text('Catalog', style: Theme.of(context).textTheme.displayLarge),
//       floating: true,
//       actions: [
//         IconButton(
//           icon: const Icon(Icons.shopping_cart),
//           onPressed: () => context.go('/cart'),
//         ),
//       ],
//     );
//   }
// }

// class _MyListItem extends StatelessWidget {
//   final int index;

//   const _MyListItem(this.index);

//   @override
//   Widget build(BuildContext context) {
//     var item = context.select<CatalogModel, Item>(
//       // Here, we are only interested in the item at [index]. We don't care
//       // about any other change.
//       (catalog) => catalog.getByPosition(index),
//     );
//     var textTheme = Theme.of(context).textTheme.titleLarge;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: LimitedBox(
//         maxHeight: 48,
//         child: Row(
//           children: [
//             AspectRatio(
//               aspectRatio: 1,
//               child: Container(
//                 color: item.color,
//               ),
//             ),
//             const SizedBox(width: 24),
//             Expanded(
//               child: Text(item.name, style: textTheme),
//             ),
//             const SizedBox(width: 24),
//             _AddButton(item: item),
//           ],
//         ),
//       ),
//     );
//   }
// }
