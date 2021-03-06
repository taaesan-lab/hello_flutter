import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

class QuoteWidget extends StatefulWidget {
  const QuoteWidget({Key? key}) : super(key: key);

  @override
  _QuoteWidgetState createState() => _QuoteWidgetState();
}

class _QuoteWidgetState extends State<QuoteWidget> {
  int _index = 0;
  final List _quotes = [
    "Be yourself; everyone else is already taken.",
    "To live is the rarest thing in the world. Most people exist, that is all.",
    "Women are made to be Loved, not understood.",
    "Be the change that you wish to see in the world.",
    "Live as if you were to die tomorrow. Learn as if you were to live forever."
        "Great minds discuss ideas; average minds discuss events; small minds discuss people.",
    "Life isn't about finding yourself. Life is about creating yourself.",
    "Success is not final, failure is not fatal: it is the courage to continue that counts.",
    "We make a living by what we get, but we make a life by what we give."
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Quote', textDirection: TextDirection.ltr),
          centerTitle: true,
          // backgroundColor: Colors.amber.shade800
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 400,
                height: 200,
                margin: EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(14.5)),
                child: Center(
                    child: Text(
                  _quotes[_index % _quotes.length],
                  // style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                ))),
            Divider(thickness: 1.3),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: TextButton.icon(
                  onPressed: _showQuote,
                  icon: Icon(Icons.wb_sunny),
                  label: Text("Inspire Me!"),
                  // style: TextButton.styleFrom(
                  //   // primary: Colors.white,
                  //   // backgroundColor: Colors.amber.shade800,
                  //   textStyle: const TextStyle(fontSize: 20),
                  // )
              ),
            ),
            Spacer()
          ],
        ),
        alignment: FractionalOffset(0.5, 0.5),
      ),
    );
  }

  void _showQuote() {
    setState(() {
      _index++;
    });
  }
}
