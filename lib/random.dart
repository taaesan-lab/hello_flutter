

import 'package:english_words/english_words.dart';
import 'package:flutter/widgets.dart';

class RandomWords extends StatefulWidget {

  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();      // NEW
    return Text(wordPair.asPascalCase + " by Taae");      // NEW
  }
}
