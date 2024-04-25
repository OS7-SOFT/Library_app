import 'package:cleane_architecture/cors/errors/failures.dart';
import 'package:cleane_architecture/features/books/domain/entities/book_entity.dart';
import 'package:cleane_architecture/features/books/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class GetBooksBySearch {
  final BooksRepository bookRepository;

  GetBooksBySearch({required this.bookRepository});

  Future<Either<Failure, List<BookEntity>>> call(String? query) async {
    return await bookRepository.getBooksBySearch(query);
  }
}


