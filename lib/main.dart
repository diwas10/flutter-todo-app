import 'package:flutter/material.dart';
import 'pages/todo.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ThemeData theme = ThemeData();
  final primaryColor = const Color.fromRGBO(48, 35, 174, 1);
  final secondaryColor = const Color.fromRGBO(200, 109, 215, 1);

  ThemeData _customTheme() {
    return ThemeData(
        // brightness: Brightness.dark,
        primaryColor: primaryColor,
        colorScheme: theme.colorScheme.copyWith(
          secondary: secondaryColor,
          primary: primaryColor,
          error: Colors.red,
        ),
        scaffoldBackgroundColor: Colors.white,
        cardColor: const Color(0xFF883B2D),
        textTheme: theme.textTheme.copyWith(
          bodyText1: TextStyle(color: secondaryColor),
          bodyText2: TextStyle(color: primaryColor),
        ),
        primaryTextTheme: TextTheme(headline6: TextStyle(color: primaryColor)),
        fontFamily: 'Georgia',
        backgroundColor: Colors.grey[100]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: _customTheme(), home: const Todos());
  }
}
