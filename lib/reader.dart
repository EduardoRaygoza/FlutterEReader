import 'package:epub/epub.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import './util/book_decoder.dart';
import './util/pager.dart';

class Reader extends StatefulWidget {
  final String url;

  Reader(this.url);

  @override
  State<StatefulWidget> createState() => _Reader(url);
}

class _Reader extends State<Reader> {
  String url;
  BookDecoder decoder;
  Future<EpubBook> book;

  _Reader(this.url) {
    book = downloadBook(url);
  }

  Future<EpubBook> downloadBook(String url) async {
    Response response = await get(url);
    if (response.statusCode == 200) {
      return EpubReader.readBook(response.bodyBytes);
    } else {
      throw Exception('Error en descarga de epub');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: book,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          decoder = BookDecoder(snapshot.data);
          return Scaffold(
              appBar: AppBar(
                title: Text(snapshot.data.Title),
              ),
              body: LayoutBuilder(
                builder: (context, constraints) {
                  return Pager(
                      decoder.content
                          .substring(0, decoder.chapters[0]['longitud']),
                      Size(constraints.maxWidth, constraints.maxHeight));
                },
              ));
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("Descargando libro...")
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          );
        }
      },
    );
  }
}
