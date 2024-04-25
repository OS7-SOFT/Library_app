import 'package:cleane_architecture/cors/errors/failures.dart';
import 'package:cleane_architecture/features/books/domain/entities/book_entity.dart';
import 'package:cleane_architecture/features/books/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllBooks {
  final BooksRepository bookRepository;

  GetAllBooks({required this.bookRepository});

  Future<Either<Failure, List<BookEntity>>> call(String? subject) async {
    return await bookRepository.getAllBooks(subject);
  }
}

