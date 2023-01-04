import 'package:flutter/material.dart';

class SubmitButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const SubmitButton({Key? key, required this.formKey}) : super(key: key);

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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('And your mom Data')),
              );
            }
          },
          child: const Text('Submit'),
        ));
  }
}

class ArticleTitleField extends StatelessWidget {
  const ArticleTitleField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        maxLength: 80,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Article title',
        ),
      ),
    );
  }
}

class ArticleContentField extends StatelessWidget {
  const ArticleContentField({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: TextField(
        maxLength: 1000,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Article content',
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const ArticleTitleField(),
          const ArticleContentField(),
          SubmitButton(
            formKey: _formKey,
          )
        ],
      ),
    );
  }
}
