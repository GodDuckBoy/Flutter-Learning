import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var wordPair = WordPair.random();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Menu"),),
        body: Center(child: Text(wordPair.asUpperCase))
      ),
    );
  }

}
