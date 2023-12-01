import 'package:leitor_de_ebooks/app/modules/home/interactor/models/book_model.dart';

abstract interface class BookRepository {
  Future<List<BookModel>>? getBooks();
  Future<String>? readBook(BookModel bookModel);
  Future<void> downloadBook(BookModel bookModel);
  Future<void>? setBookToFavorite(List<BookModel> books);
  Future<List<BookModel>?> getBookToFavorite();
}
