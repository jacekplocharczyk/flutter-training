import 'package:flutter/material.dart';
import 'package:training_app/models/library.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

class SubmitButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController articleContentController;
  const SubmitButton(
      {Key? key,
      required this.formKey,
      required this.titleController,
      required this.articleContentController})
      : super(key: key);

  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12),
        child: ElevatedButton(
          onPressed: () {
            if (widget.formKey.currentState!.validate()) {
              var articleList =
                  Provider.of<ArticleListModel>(context, listen: false);
              String title = widget.titleController.text;
              String content = widget.articleContentController.text;
              String status = "running";
              articleList.addArticle(title, status, content);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Item added: $title')),
              );
              context.pushReplacement('/');
            }
          },
          child: const Text('Submit'),
        ));
  }
}

class ArticleTitleField extends StatefulWidget {
  final TextEditingController controller;

  const ArticleTitleField({Key? key, required this.controller})
      : super(key: key);

  @override
  State<ArticleTitleField> createState() => _ArticleTitleFieldState();
}

class _ArticleTitleFieldState extends State<ArticleTitleField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        controller: widget.controller,
        maxLength: 80,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Article title',
        ),
      ),
    );
  }
}

class ArticleContentField extends StatefulWidget {
  final TextEditingController controller;

  const ArticleContentField({Key? key, required this.controller})
      : super(key: key);

  @override
  State<ArticleContentField> createState() => _ArticleContentFieldState();
}

class _ArticleContentFieldState extends State<ArticleContentField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        controller: widget.controller,
        maxLength: 1000,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Article content',
        ),
      ),
    );
  }
}

class AddArticlePage extends StatefulWidget {
  final titleController = TextEditingController();
  final articleContentController = TextEditingController();

  AddArticlePage({super.key});

  @override
  AddArticlePageState createState() {
    return AddArticlePageState();
  }
}

class AddArticlePageState extends State<AddArticlePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new article'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pushReplacement('/');
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ArticleTitleField(controller: widget.titleController),
            ArticleContentField(controller: widget.articleContentController),
            SubmitButton(
              formKey: _formKey,
              titleController: widget.titleController,
              articleContentController: widget.articleContentController,
            )
          ],
        ),
      ),
    );
  }
}

