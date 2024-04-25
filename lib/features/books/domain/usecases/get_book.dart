
import 'package:cleane_architecture/cors/errors/failures.dart';
import 'package:cleane_architecture/features/books/domain/entities/book_entity.dart';
import 'package:cleane_architecture/features/books/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class GetBook {
  final BooksRepository repository;
  GetBook({required this.repository});

  Future<Either<Failure, BookEntity>> call(String id) async {
    return await repository.getBook(id);
  }
}
