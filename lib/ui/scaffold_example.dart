import 'package:flutter/material.dart';

import 'custom_button.dart';

class ScaffoldExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scaffold', textDirection: TextDirection.ltr),
        centerTitle: true,
        backgroundColor: Colors.amber.shade800,
        actions: [
          IconButton(
              onPressed: () => debugPrint('Tab on alert'),
              icon: Icon(Icons.add_box_rounded))
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton()
            // InkWell(
            //   child: Text(
            //     'Tap me!',
            //     style: TextStyle(fontSize: 23.4),
            //   ),
            //   onTap: () => debugPrint('Tab me!'),
            // )
          ],
        ),
      ),
    );
  }
}


