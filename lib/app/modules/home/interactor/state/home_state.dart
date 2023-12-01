// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:leitor_de_ebooks/app/modules/home/interactor/models/book_model.dart';

sealed class HomeState {
  const HomeState();
}

class InitialHomeState implements HomeState {}

class LoadingHomeState implements HomeState {}

class GetedBooksHomeState implements HomeState {
  final List<BookModel> books;
  GetedBooksHomeState({required this.books});
}

class ErrorHomeState implements HomeState {
  final String message;
  ErrorHomeState({required this.message});
}
