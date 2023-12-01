import 'package:flutter/material.dart';
import 'package:leitor_de_ebooks/app/core/constants/app_colors.dart';
import 'package:leitor_de_ebooks/app/modules/home/interactor/models/book_model.dart';
import 'package:leitor_de_ebooks/app/modules/home/interactor/repository/book_repository.dart';
import 'package:leitor_de_ebooks/app/modules/home/interactor/state/home_state.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class HomeController extends ChangeNotifier {
  final BookRepository bookRepository;

  HomeController(this.bookRepository);

  HomeState homeState = InitialHomeState();
  List<BookModel>? _books;

  Future<void> getBooks() async {
    homeState = LoadingHomeState();
    notifyListeners();
    try {
      _books = await bookRepository.getBooks() ?? [];
      homeState = GetedBooksHomeState(books: _books!);
      notifyListeners();
    } catch (e) {
      homeState = ErrorHomeState(message: e.toString());
      notifyListeners();
    }
  }

  Future<void> readBook(BookModel bookModel) async {
    final path = await bookRepository.readBook(bookModel);
    if (path != null) {
      VocsyEpub.setConfig(
        themeColor: AppColors.grey,
        identifier: "book",
        scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
        allowSharing: true,
        enableTts: true,
        nightMode: true,
      );
      VocsyEpub.open(
        path,
      );
    }
  }

  Future<void> downloadBook(BookModel bookModel) async {
    await bookRepository.downloadBook(bookModel);
  }

  Future<void> setFavoriteBook(BookModel bookModel, bool favorite) async {
    if (_books != null) {
      final bookIndex = _books!.indexWhere((book) => book.id == bookModel.id);

      if (bookIndex != -1) {
        _books![bookIndex].isFavorite = favorite;
        bookRepository.setBookToFavorite(_books!);
        notifyListeners();
      }
    }
  }

  Future<void> getFavoriteBook() async {
    final favoriteBooks = await bookRepository.getBookToFavorite();
    if (_books == null) {
      await getBooks();
    }
    if (favoriteBooks != null && _books != null) {
      for (var book1 in _books!) {
        var book2 = favoriteBooks.firstWhere(
            (element) => element.id == book1.id,
            orElse: () => BookModel(
                id: book1.id,
                title: book1.title,
                author: book1.author,
                coverUrl: book1.coverUrl,
                downloadUrl: book1.downloadUrl));
        book1.isFavorite = book2.isFavorite;
      }
     notifyListeners();
    }
  }
  
}
