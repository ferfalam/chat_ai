import 'package:flutter/material.dart';
import 'package:open_ai/screens/image_chat.dart';
import 'package:open_ai/screens/splash_screen.dart';
import 'package:open_ai/screens/text_chat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MySplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/chat' : (context) => TextChat(),
        '/image' : (context) => ImageChat(),
      },
    );
  }
}
