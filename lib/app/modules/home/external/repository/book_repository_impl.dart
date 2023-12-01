import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:leitor_de_ebooks/app/modules/home/interactor/mappers/book_mapper.dart';
import 'package:leitor_de_ebooks/app/modules/home/interactor/models/book_model.dart';
import 'package:leitor_de_ebooks/app/modules/home/interactor/repository/book_repository.dart';
import 'package:leitor_de_ebooks/app/services/http_client_service.dart';
import 'package:leitor_de_ebooks/app/services/local_storage_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookRepositoryImpl implements BookRepository {
  final IHttpClient httpClient;
  final ILocalStorageService iLocalStorageService;

  BookRepositoryImpl(this.httpClient, this.iLocalStorageService);

  @override
  Future<void> downloadBook(BookModel bookModel) async {
    await launchUrl(Uri.parse(bookModel.downloadUrl));
  }

  @override
  Future<List<BookModel>>? getBooks() async {
    final Response response =
        await httpClient.get("https://escribo.com/books.json");

    return BookMapper.getBookFromMap(response.data);
  }

  @override
  Future<String>? readBook(BookModel bookModel) async {
    final response = await httpClient.get(bookModel.downloadUrl);

    if (response.statusCode == 200) {
      final documentsDirectory = Platform.isAndroid
          ? await getExternalStorageDirectory()
          : await getApplicationDocumentsDirectory();
      String path = '${documentsDirectory!.path}/${bookModel.title}.epub';

      File file = File(path);

      if (!File(path).existsSync()) {
        await file.create();
        await httpClient.download(
          bookModel.downloadUrl,
          path,
          (receivedBytes, totalBytes) {
            debugPrint(
                'obtendo ebook --- ${(receivedBytes / totalBytes) * 100}');
          },
          true,
        );
      }
      return path;
    } else {
      throw Exception('Erro ao obter o ebook');
    }
  }

  @override
  Future<void>? setBookToFavorite(List<BookModel> books) async {
    await iLocalStorageService.put("favoriteBooks", jsonEncode(books));
  }

  @override
  Future<List<BookModel>?> getBookToFavorite() async {
    final result = await iLocalStorageService.recovery("favoriteBooks");
    if (result != null) {
      final List books = jsonDecode(result);

      return books.map((e) => BookModel.fromJson(e)).toList();
    }
    return null;
  }
}
