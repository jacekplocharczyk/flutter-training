import 'package:flutter/material.dart';
// import 'package:training_app/screens/library.dart';

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
        padding: const EdgeInsets.symmetric(vertical: 26.0),
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
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          SubmitButton(
            formKey: _formKey,
          )
        ],
      ),
    );
  }
}
