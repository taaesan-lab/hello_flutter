import 'package:flutter/material.dart';
import 'package:hello_flutter/ui/day6/movie_list.dart';
import 'package:hello_flutter/ui/day4/quote_of_the_day.dart';

// import 'ui/split-calculator.dart';
// import 'ui/quote_of_the_day.dart';
// import 'ui/random.dart';
// import 'ui/scaffold_example.dart';
import 'ui/day7/custom_theme.dart';


void main() => runApp(new MaterialApp(
      // theme: buildAppTheme(),
      // theme: ThemeData(
      //   brightness: Brightness.dark,
      //   primaryColor: Colors.pinkAccent,
      // ),
      // home: RandomWords()
      // home: ScaffoldExample()
      home: QuoteWidget(),
      // home: MovieListWidget(),
      debugShowCheckedModeBanner: false,
    ));
