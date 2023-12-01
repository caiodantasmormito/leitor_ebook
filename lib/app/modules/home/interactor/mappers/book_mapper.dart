import 'package:leitor_de_ebooks/app/modules/home/interactor/models/book_model.dart';

class BookMapper {
  static List<BookModel> getBookFromMap(List<dynamic> maps) {
    final result = maps.map((e) => BookModel.fromMap(e)).toList();
    return result;
  }
}
