import 'package:cleane_architecture/cors/constants/constants.dart';
import 'package:cleane_architecture/features/books/domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  const BookModel({
    required String id,
    required String? title,
    required String? description,
    required String? imageUrl,
    required List<dynamic>? authors,
    required dynamic averageRating,
    required int? ratingsCount,
    required int? pageCount,
    required String? publishedDate,
    required String? webReaderLink,
  }) : super(
            id: id,
            title: title,
            authors: authors,
            averageRating: averageRating,
            ratingsCount: ratingsCount,
            description: description,
            imageUrl: imageUrl,
            pageCount: pageCount,
            publishedDate: publishedDate,
            webReaderLink: webReaderLink);

  factory BookModel.fromJson(Map<String, dynamic> jsonData) {
    return BookModel(
        id: jsonData[kId],
        title: jsonData[kVolumeInfo][kTitle],
        description: jsonData[kVolumeInfo][kDescription],
        imageUrl: jsonData[kVolumeInfo][kImageLinks][kThumbnail],
        authors: jsonData[kVolumeInfo][kAuthors],
        ratingsCount: jsonData[kVolumeInfo][kRatingsCount],
        averageRating: jsonData[kVolumeInfo][kAverageRating],
        pageCount: jsonData[kVolumeInfo][kPageCount],
        publishedDate: jsonData[kVolumeInfo][kPublishedDate],
        webReaderLink: jsonData[kAccessInfo][kWebReaderLink]);
  }

  Map<String, dynamic> toJson() {
    return {
        kId: id,
      kVolumeInfo: {
        kTitle: title,
        kDescription: description,
        kImageLinks: {
          kThumbnail: imageUrl,
        },
        kPageCount: pageCount,
        kPublishedDate: publishedDate,
      },
      kAccessInfo: {kWebReaderLink: webReaderLink}
    };
  }
}
