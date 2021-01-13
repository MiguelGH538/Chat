import 'package:flutter/material.dart';
 
import 'package:chat_web_app_example/src/pages/chat_page.dart';

void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: ChatPage()
    );
  }
}