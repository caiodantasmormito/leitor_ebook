import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:leitor_de_ebooks/app/modules/home/external/repository/book_repository_impl.dart';
import 'package:leitor_de_ebooks/app/services/http_client_service.dart';
import 'package:leitor_de_ebooks/app/services/local_storage_service.dart';
import 'package:mocktail/mocktail.dart';

class IHttpClientMock extends Mock implements IHttpClient {}

class IlocalStorageMock extends Mock implements ILocalStorageService {}

class ResponseMock extends Mock implements Response {}

void main() {
  group('book repository test', () {
    test("Deve retornar uma lista de books", () async {
      final dio = IHttpClientMock();
      final shared = IlocalStorageMock();
      final response = ResponseMock();

      when(() => response.data).thenReturn(listBook);
      when(() => dio.get(any())).thenAnswer((_) async => response);

      final bookRepository = BookRepositoryImpl(dio, shared);
      final books = await bookRepository.getBooks();
      expect(books![0].title, "The Bible of Nature");
    });
  });
}

final listBook = [
  {
    "id": 1,
    "title": "The Bible of Nature",
    "author": "Oswald, Felix L.",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/72134/pg72134.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/72134.epub3.images"
  },
  {
    "id": 2,
    "title": "Kazan",
    "author": "Curwood, James Oliver",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/72127/pg72127.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/72127.epub.images"
  },
  {
    "id": 3,
    "title": "Mythen en sagen uit West-Indië",
    "author": "Cappelle, Herman van, Jr.",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/72126/pg72126.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/72126.epub.noimages"
  },
  {
    "id": 4,
    "title": "Lupe",
    "author": "Affonso Celso",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/63606/pg63606.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/63606.epub3.images"
  },
  {
    "id": 4,
    "title": "Lupe",
    "author": "Affonso Celso",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/63606/pg63606.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/63606.epub3.images"
  },
  {
    "id": 5,
    "title": "Nuorta ja vanhaa väkeä: Kokoelma kertoelmia",
    "author": "Fredrik Nycander",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/72135/pg72135.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/72135.epub3.images"
  },
  {
    "id": 6,
    "title": "Among the Mushrooms: A Guide For Beginners",
    "author": "Burgin and Dallas",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/18452/pg18452.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/18452.epub3.images"
  },
  {
    "id": 7,
    "title": "The History of England in Three Volumes, Vol.III.",
    "author": "Edward Farr and E. H. Nolan",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/19218/pg19218.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/19218.epub3.images"
  },
  {
    "id": 8,
    "title": "Adventures of Huckleberry Finn",
    "author": "Mark Twain",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/76/pg76.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/76.epub3.images"
  },
  {
    "id": 9,
    "title": "The octopus: or, The 'devil-fish' of fiction and of fact",
    "author": "Henry Lee",
    "cover_url":
        "https://www.gutenberg.org/cache/epub/72133/pg72133.cover.medium.jpg",
    "download_url": "https://www.gutenberg.org/ebooks/72133.epub3.images"
  }
];
