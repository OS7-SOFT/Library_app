import 'package:cleane_architecture/features/books/presentation/pages/book_details.dart';
import 'package:cleane_architecture/features/books/presentation/providers/books_provider.dart';
import 'package:cleane_architecture/features/books/presentation/widgets/image_widget.dart';
import 'package:cleane_architecture/features/books/presentation/widgets/rating_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class BookWidget extends StatelessWidget {
  final String id;
  final String? title;
  final String? imageUrl;
  final dynamic averageRating;
  final dynamic ratingCount;

  const BookWidget({
    Key? key,
    required this.id,
    this.title,
    this.imageUrl,
    this.averageRating,
    this.ratingCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.all(10),
      onPressed: () {
        Provider?.of<BooksProvider>(context, listen: false).eitherFailureOrBook(id);
        Navigator.push(
            context,
            MaterialPageRoute(
              
              builder: (context) => BookDetails(),
            ));
      },
      child: Card(
        color: Colors.white,
        elevation: 5,
        shadowColor: Colors.grey[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageWidget(url:imageUrl!,width: 150,height:170 ,),
            _buildTitle(title!),
            Padding(
              padding: const EdgeInsets.only(left: 5,top: 3),
              child: RatingWidget(averageRating: averageRating,ratingCount: ratingCount,),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox _buildTitle(String bookTitle) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          bookTitle,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
          maxLines: 1,
        ),
      ),
    );
  }
}
