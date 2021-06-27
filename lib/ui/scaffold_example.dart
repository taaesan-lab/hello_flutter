
import 'package:flutter/material.dart';

class ScaffoldExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scaffold', textDirection: TextDirection.ltr),
        centerTitle: true,
        backgroundColor: Colors.amber.shade800,
        actions: [
          IconButton(onPressed: ()=> debugPrint('Tab on alert'), icon: Icon(Icons.add_box_rounded))
        ],
      ),
      body: Center(
        child: Text('Hello Scaffold', textDirection: TextDirection.ltr),
      ),
    );
  }
}
