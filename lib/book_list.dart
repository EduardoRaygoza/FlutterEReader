import 'package:flutter/material.dart';

import './reader.dart';

class BookList extends StatelessWidget {
  final List<Map<String, String>> books = [
    {'url': 'http://www.gutenberg.org/ebooks/59868.epub.noimages'},
    {'url': 'http://www.gutenberg.org/ebooks/59863.epub.noimages'},
    {'url': 'http://www.gutenberg.org/ebooks/59861.epub.noimages'},
    {'url': 'http://www.gutenberg.org/ebooks/59862.epub.noimages'},
    {'url': 'http://www.gutenberg.org/ebooks/59865.epub.noimages'},
  ];

  Widget buildBook(BuildContext context, int index) {
    return Card(
      child: Column(
        children: <Widget>[
          Text('Libro numero $index'),
          RaisedButton(
            child: Text('Leer'),
            onPressed: () {
              print(books[index]['url']);
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Reader(books[index]['url']),
              ));
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: buildBook,
    );
  }
}