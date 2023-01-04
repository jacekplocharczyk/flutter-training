import 'package:flutter/material.dart';
import 'package:training_app/screens/library.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter State Management Basic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LibraryPage(),
    );
  }
}
