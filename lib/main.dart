import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'exploration',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello Dude"),
      ),
      body: Column(children: [Progress(), TaskList()]),
    );
  }
}

class Progress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("What the hell"),
      LinearProgressIndicator(
        value: 0.9,
      )
    ]);
  }
}

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TaskItem(
          label: 'First article',
        ),
        TaskItem(label: 'Second article')
      ],
    );
  }
}

class TaskItem extends StatefulWidget {
  final String label;

  const TaskItem({Key? key, required this.label}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool? _value = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            value: _value,
            onChanged: (newValue) => setState(() => _value = newValue)),
        Text(widget.label)
      ],
    );
  }
}
