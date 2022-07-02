import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18);
  final _saved = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StartApp Generator"),
        actions: [
          IconButton(onPressed: _pushSaved, icon: Icon(Icons.list))
        ],),
      body:  ListView.builder(itemBuilder: (context, i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        final alreadySaved = _saved.contains(_suggestions[index]);
        return ListTile(title: Text(
          _suggestions[index].asPascalCase,
          style: _biggerFont,
        ),
          trailing: Icon(alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,),
          onTap: () {
            setState(() {
              if (alreadySaved) {
                _saved.remove(_suggestions[index]);
              }
              else {
                _saved.add(_suggestions[index]);
              }
            }
            );
          },
        );
      }),
    );

  }
  void _pushSaved() {
    Navigator.of(context).push(
        MaterialPageRoute<void> (
            builder: (context) {

              final tiles = _saved.map((pair) {
                return ListTile(
                  title: Text(pair.asPascalCase),
                );
              });
              return Scaffold(
                  appBar: AppBar(title: Text("Saved"),),
                  body: ListView(children: tiles.toList(),),
              );
            }
        )
    );
  }
}

