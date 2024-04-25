import 'package:cleane_architecture/features/books/domain/entities/book_entity.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'book_widget.dart';

class BookListWidget extends StatelessWidget {
  final List<BookEntity> books;

  const BookListWidget({
    Key? key,
    required this.books,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      height: 555,
      child: GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          padding:const EdgeInsets.only(top:40,left: 10,right: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            mainAxisExtent: 250,crossAxisSpacing: 20
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            return BookWidget(
              id: books[index].id,
              title: books[index].title,
              imageUrl: books[index].imageUrl,
              averageRating: books[index].averageRating,
              ratingCount: books[index].ratingsCount
            );
          }),
    );
  }
}
