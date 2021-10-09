import 'package:flutter/material.dart';
import 'pages/todo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          fontFamily: 'Georgia',
          brightness: Brightness.light,
        ),
        home: const Todos());
  }
}
