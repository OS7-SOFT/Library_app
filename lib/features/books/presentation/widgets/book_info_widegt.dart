import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleane_architecture/cors/errors/failures.dart';
import 'package:cleane_architecture/cors/widgets/failure_message_widget.dart';
import 'package:cleane_architecture/cors/widgets/loading_widget.dart';
import 'package:cleane_architecture/features/books/domain/entities/book_entity.dart';
import 'package:cleane_architecture/features/books/presentation/providers/books_provider.dart';
import 'package:cleane_architecture/features/books/presentation/widgets/rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookInfoWidget extends StatelessWidget {
  const BookInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _booksProvider = Provider.of<BooksProvider>(context);
    BookEntity? _book = _booksProvider.book;
    Failure? failure = _booksProvider.failure;

    if (_book != null) {
      return _buildBookContent(_book);
    } else if (failure != null) {
      return _buildMessage(failure, _booksProvider);
    } else {
      return const Center(child: LoadingWidget());
    }
  }

  Center _buildMessage(Failure failure, BooksProvider _booksProvider) {
    return Center(
        child: Column(
      children: [
        FailureMessageWiget(message: failure.getMessage),
        TextButton(
            onPressed: () {
              _booksProvider.eitherFailureOrBook(_booksProvider.bookId);
            },
            child: const Text("Try again"))
      ],
    ));
  }

  Column _buildBookContent(BookEntity book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildImage(book.imageUrl!),
            const SizedBox(
              width: 20,
            ),
            _buildInfo(book)
          ],
        ),
        const Divider(color: Colors.black),
        _buildDescreption(book.description!),
      ],
    );
  }

  Column _buildInfo(BookEntity book) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 180, child: _buildTitle(book.title!)),
        Text("${book.pageCount} Pages"),
        Padding(
          padding: const EdgeInsets.only(top: 3, bottom: 8),
          child: Text("Published : ${book.publishedDate}"),
        ),
        RatingWidget(
          averageRating: book.averageRating,
          ratingCount: book.ratingsCount,
          size: 15,
          isCenter: true,
        ),
        _buildButton(book.webReaderLink!),
      ],
    );
  }

  Padding _buildDescreption(String descript) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Text(
        descript,
        style: TextStyle(wordSpacing: 2, letterSpacing: 1),
        textAlign: TextAlign.justify,
        textScaleFactor: 1.1,
        maxLines: 17,
      ),
    );
  }

  Container _buildButton(String? url) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      width: 100,
      height: 30,
      child:url ==null? const Text("un available to read") :ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.green),
          ),
          onPressed: () {
            
          },
          child: const Text(
            "Read",
            style: TextStyle(fontSize: 18),
          )),
    );
  }

  Padding _buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 5),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey[600]),
      ),
    );
  }

  Card _buildImage(String url) {
    return Card(
      margin: const EdgeInsets.only(top: 20),
      elevation: 10,
      child: CachedNetworkImage(
        height: 190,
        imageUrl: url,
        placeholder: (context, url) => Image.asset(
          "images/placeholder.jpg",
          height: 130,
          width: 130,
        ),
        errorWidget: (context, url, _) => Image.asset(
          "images/placeholder.jpg",
          height: 130,
          width: 130,
        ),
      ),
    );
  }
}
