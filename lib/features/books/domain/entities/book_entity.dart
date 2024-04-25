import 'package:equatable/equatable.dart';

class BookEntity extends Equatable {
  final String id;
  final String? title;
  final List<dynamic>? authors;
  final String? imageUrl;
  final int? ratingsCount;
  final dynamic averageRating;
  final String? description;
  final String? publishedDate;
  final int? pageCount;
  final String? webReaderLink;

  const BookEntity(
      {required this.id,
      required this.title,
      required this.authors,
      required this.imageUrl,
      required this.averageRating,
      required this.ratingsCount,
      required this.description,
      required this.publishedDate,
      required this.pageCount,
      required this.webReaderLink});

  @override
  List<Object?> get props => [
        id,
        title,
        authors,
        imageUrl,
        description,
        publishedDate,
        pageCount,
        webReaderLink
      ];
}
