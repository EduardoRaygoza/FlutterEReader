import 'package:flutter/material.dart';

import './book_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ePUB reader'),
        ),
        body: BookList(),
      ),
    );
  }
}
