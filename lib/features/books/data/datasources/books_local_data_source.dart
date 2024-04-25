import 'dart:convert';

import 'package:cleane_architecture/cors/errors/exceptions.dart';
import 'package:cleane_architecture/features/books/data/models/book_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BooksLocalDataSource {
  Future<List<BookModel>> getCachedBooks();

  Future<Unit> cacheBooks(List<BookModel> bookModels);
}

const cachedBooks = "CACHED_BOOKS";

class BooksLocalDataSourceImpl extends BooksLocalDataSource {
  final SharedPreferences sharedPreferences;

  BooksLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Unit> cacheBooks(List<BookModel> bookModels) {
    List bookModelsToJson = bookModels
        .map<Map<String, dynamic>>((bookModel) => bookModel.toJson())
        .toList();
    sharedPreferences.setString(cachedBooks, json.encode(bookModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<BookModel>> getCachedBooks() {
    final jsonString = sharedPreferences.getString(cachedBooks);
    if (jsonString != null) {
      List jsonDecode = json.decode(jsonString);
      List<BookModel> jsonToBookModels = jsonDecode
          .map<BookModel>((jsonData) => BookModel.fromJson(jsonData))
          .toList();
      return Future.value(jsonToBookModels);
    } else {
      throw EmptyCacheException();
    }
  }
}
