import 'package:flutter/material.dart';
import 'package:igemtflite/mysplashpage.dart';



Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'tflite demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MySplashPage());
  }
}
