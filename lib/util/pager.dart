import 'package:flutter/material.dart';
import 'dart:math';

class Pager extends StatefulWidget {
  final String _content;
  final Size _size;

  Pager(this._content, this._size);

  createState() => _PagerState(_content, _size);
}

class _PagerState extends State<Pager> {
  String _content;
  Future<List<String>> pages;
  Random generator;
  int currentPage, random;
  static const double _fontSize = 13.0;
  Size _size;

  _PagerState(this._content, this._size);

  @override
  void initState() {
    super.initState();
    pages = divideContent(_content);
    currentPage = 0;
    generator = Random();
    random = (generator.nextInt(9) + 1);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showSnackBar(BuildContext context, int index) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Pagina $index'),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {},
        textColor: Colors.indigo,
      ),
      backgroundColor: Colors.blue,
    ));
  }

  Future<List<String>> divideContent(String content) async{
    List<String> _pages = [];
    List<String> _words = content.split(' ');
    String _text = "";
    double _maxWidth = _size.width - 20.0;

    TextPainter textPainter = TextPainter(
        text: TextSpan(text: _text , style: TextStyle(fontSize: _fontSize)),
        textAlign: TextAlign.justify,
        textDirection: TextDirection.ltr,
        maxLines: (_size.height / (_fontSize+3)).floor())
    ..layout(maxWidth: _maxWidth);

    while(_words.isNotEmpty){
      _text += _words.removeAt(0) + " ";
      textPainter.text = TextSpan(text: _text, style: TextStyle(fontSize: _fontSize));
      textPainter.layout(maxWidth: _maxWidth);
      if(textPainter.didExceedMaxLines){
        _pages.add(_text);
        _text = "";
      }
    }
    return _pages;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pages,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return PageView.builder(
            itemCount: snapshot.data.length,
            onPageChanged: (index) {
              if (index != currentPage) {
                currentPage = index;
                if (currentPage == random) {
                  showSnackBar(context, index);
                  random += (generator.nextInt(9)) + 1;
                }
              }
            },
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  snapshot.data[index],
                  style: TextStyle(fontSize: _fontSize),
                  textAlign: TextAlign.justify,
                ),
              );
            },
          );
        } else {
          return Scaffold(
            body: Center(
              child: Column(children: <Widget>[
                CircularProgressIndicator(),
                Text("Procesando libro...")
                ],
              ),
            ),
          );
        }
      }
    );
  }
}
