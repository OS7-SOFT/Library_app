import 'package:cleane_architecture/cors/errors/failures.dart';
import 'package:cleane_architecture/cors/network/network_info.dart';
import 'package:cleane_architecture/features/books/data/datasources/books_local_data_source.dart';
import 'package:cleane_architecture/features/books/data/datasources/books_remote_data_source.dart';
import 'package:cleane_architecture/features/books/data/repositories/books_repository_impl.dart';
import 'package:cleane_architecture/features/books/domain/entities/book_entity.dart';
import 'package:cleane_architecture/features/books/domain/usecases/get_all_books.dart';
import 'package:cleane_architecture/features/books/domain/usecases/get_book.dart';
import 'package:cleane_architecture/features/books/domain/usecases/get_books_by_search.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class BooksProvider extends ChangeNotifier {
  List<BookEntity>? books;
  List<BookEntity>? booksBySearch;
  BookEntity? book;
  Failure? failure;

  BooksProvider({this.failure, this.books, this.book});

  String _bookId = "";

  String get bookId => _bookId;

  void eitherFailureOrBooks(String? subject) async {
    if (failure != null || books != null) {
      failure = null;
      books = null;
      notifyListeners();
    }

    BooksRepositoryImpl booksRepository = BooksRepositoryImpl(
        localDataSource: BooksLocalDataSourceImpl(
            sharedPreferences: await SharedPreferences.getInstance()),
        remoteDataSource: BooksRemoteDataSourceImpl(client: http.Client()),
        networkInfo: NetworkInfoImpl(InternetConnectionChecker()));

    final failureOrBooks =
        await GetAllBooks(bookRepository: booksRepository).call(subject);

    failureOrBooks.fold((Failure newFailure) {
      failure = newFailure;
      books = null;
    }, (List<BookEntity> newBooks) {
      books = newBooks;
      failure = null;
    });
    notifyListeners();
  }


  void eitherFailureOrBooksBySearch(String? query) async {
    if (failure != null || booksBySearch != null) {
      failure = null;
      booksBySearch = null;
   
    }

    BooksRepositoryImpl booksRepository = BooksRepositoryImpl(
        localDataSource: BooksLocalDataSourceImpl(
            sharedPreferences: await SharedPreferences.getInstance()),
        remoteDataSource: BooksRemoteDataSourceImpl(client: http.Client()),
        networkInfo: NetworkInfoImpl(InternetConnectionChecker()));

    final failureOrBooks =
        await GetBooksBySearch(bookRepository: booksRepository).call(query);

    failureOrBooks.fold((Failure newFailure) {
      failure = newFailure;
      booksBySearch = null;
    }, (List<BookEntity> newBooks) {
      booksBySearch = newBooks;
      failure = null;
    });
    notifyListeners();
  }


  void eitherFailureOrBook(String id) async {
    if (failure != null || book != null) {
      failure = null;
      book = null;
      notifyListeners();
    }

    BooksRepositoryImpl booksRepository = BooksRepositoryImpl(
        localDataSource: BooksLocalDataSourceImpl(
            sharedPreferences: await SharedPreferences.getInstance()),
        remoteDataSource: BooksRemoteDataSourceImpl(client: http.Client()),
        networkInfo: NetworkInfoImpl(InternetConnectionChecker()));

    final failureOrBooks = await GetBook(repository: booksRepository).call(id);

    failureOrBooks.fold((Failure newFailure) {
      failure = newFailure;
      book = null;
      _bookId = id;
    }, (BookEntity newBookEntity) {
      book = newBookEntity;
      failure = null;
    });
    notifyListeners();
  }
}
