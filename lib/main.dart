import 'package:flutter/material.dart';
import 'pages/ConversationPageList.dart';

void main() => runApp(Messenger());

class Messenger extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Messenger',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConversationPageList(),
    );
  }
}