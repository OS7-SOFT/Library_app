import 'package:cleane_architecture/cors/errors/exceptions.dart';
import 'package:cleane_architecture/cors/network/network_info.dart';
import 'package:cleane_architecture/features/books/data/datasources/books_local_data_source.dart';
import 'package:cleane_architecture/features/books/data/datasources/books_remote_data_source.dart';
import 'package:cleane_architecture/features/books/data/models/book_model.dart';
import 'package:cleane_architecture/features/books/domain/entities/book_entity.dart';
import 'package:cleane_architecture/cors/errors/failures.dart';
import 'package:cleane_architecture/features/books/domain/repositories/books_repository.dart';
import 'package:dartz/dartz.dart';

class BooksRepositoryImpl extends BooksRepository {
  final BooksLocalDataSource localDataSource;
  final BooksRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BooksRepositoryImpl(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<BookEntity>>> getAllBooks(String? subject) async {
    if (await networkInfo.isConnection) {
      try {
        List<BookModel> remoteBooks =
            await remoteDataSource.getAllBooks(subject);
        localDataSource.cacheBooks(remoteBooks);
        return Right(remoteBooks);
      } on ServerException {
        return Left(ServerFailure(message: "Error in Server"));
      }
    } else {
      try {
        if(subject == ''){
List<BookModel> localBooks = await localDataSource.getCachedBooks();

        return Right(localBooks);
        }else{
           return Left(OfflineFailure(message: "Connect to internet"));
        }
        
      } on EmptyCacheException {
        return Left(EmptyCacheFailure(message: "No there any Local data"));
      }
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getBooksBySearch(
      String? query) async {
    if (await networkInfo.isConnection) {
      try {
        List<BookModel> remoteBooks =
            await remoteDataSource.getBooksBySearch(query);
        return Right(remoteBooks);
      } on ServerException {
        return Left(ServerFailure(message: "There are error in the server"));
      }
    } else {
      return Left(
          OfflineFailure(message: "No there any connection by internet"));
    }
  }

  @override
  Future<Either<Failure, BookEntity>> getBook(String id) async {
    if (await networkInfo.isConnection) {
      try {
        BookModel bookModel = await remoteDataSource.getBook(id);

        return Right(bookModel);
      } on ServerException {
        return Left(ServerFailure(message: "There are error in the server"));
      }
    } else {
      return Left(OfflineFailure(message: "No there any internet"));
    }
  }
}
