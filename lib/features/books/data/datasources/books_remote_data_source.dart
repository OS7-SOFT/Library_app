import 'dart:convert';
import 'package:cleane_architecture/cors/errors/exceptions.dart';
import 'package:cleane_architecture/features/books/data/models/book_model.dart';
import 'package:http/http.dart' as http;

abstract class BooksRemoteDataSource {
  Future<List<BookModel>> getAllBooks(String? subject);
  Future<List<BookModel>> getBooksBySearch(String? query);
  Future<BookModel> getBook(String id);
}

const baseUrl = "https://www.googleapis.com/books/v1/volumes";

class BooksRemoteDataSourceImpl extends BooksRemoteDataSource {
  final http.Client client;

  BooksRemoteDataSourceImpl({required this.client});

  @override
  Future<List<BookModel>> getAllBooks(String? subject) async {
    var url =
        "$baseUrl?q=${subject != '' ? 'subject:$subject' : "%27%27"}";
    return await getBookFromGoogle(url);
  }

  @override
  Future<List<BookModel>> getBooksBySearch(String? query) async {
    String url = "$baseUrl?q=$query";
    return await getBookFromGoogle(url);
  }

  @override
  Future<BookModel> getBook(String id) async {
    final response = await http.get(Uri.parse('$baseUrl/$id'),
        headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = jsonDecode(response.body);

      BookModel bookModel = BookModel.fromJson(decodedJson);
      return bookModel;
    } else {
      throw ServerException();
    }
  }

  Future<List<BookModel>> getBookFromGoogle(String url) async {
    final response = await client
        .get(Uri.parse(url), headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);
      final List items = decodedJson['items'] as List;
      print(items.length);
      final List<BookModel> booksModel = items
          .map<BookModel>((jsonData) => BookModel.fromJson(jsonData))
          .toList();

      return booksModel;
    } else {
      throw ServerException();
    }
  }
}
