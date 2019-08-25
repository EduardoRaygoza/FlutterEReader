import 'package:epub/epub.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';

class BookDecoder {

  EpubBook _book;
  String content;
  List<Map<String, dynamic>> chapters;
  

  BookDecoder(this._book): assert(null != _book){
    content = '';
    chapters = [];
    generateContent();
  }

  void generateContent(){
    dom.Document document;
    String text;
    _book.Chapters.forEach((chapter) {
      document = parse(chapter.HtmlContent);
      text = document.body.text;
      chapters.add({
        'titulo': chapter.Title,
        'longitud': text.length,
        'inicio': content.length
      });
      content += text;
    });
  }

}