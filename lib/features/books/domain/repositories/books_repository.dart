import 'package:cleane_architecture/cors/errors/failures.dart';
import 'package:cleane_architecture/features/books/domain/entities/book_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BooksRepository {
  Future<Either<Failure, List<BookEntity>>> getAllBooks(String? subject);
  Future<Either<Failure, List<BookEntity>>> getBooksBySearch(String? query);
  Future<Either<Failure, BookEntity>> getBook(String id);
}
