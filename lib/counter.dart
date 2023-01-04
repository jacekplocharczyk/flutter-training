// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainModel extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  set counter(int value) {
    if (value != _counter) {
      _counter = value;
      notifyListeners();
    }
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter State Management Basic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter State Management Basic'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainModel(),
      child: Consumer<MainModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: MyBody(model: model),
          floatingActionButton: FloatingActionButton(
            onPressed: () => model.counter++,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class MyBody extends StatefulWidget {
  final MainModel model;
  const MyBody({Key? key, required this.model}) : super(key: key);

  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '${widget.model.counter}',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
