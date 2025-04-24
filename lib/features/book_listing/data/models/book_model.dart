import 'package:hive/hive.dart';
import '../../domain/entities/book_entity.dart';
part 'book_model.g.dart';

// date: 25 April 2025
// by: Fouad
// last modified at: 25 April 2025
// This code defines a BookModel class that represents a book with various attributes.
// It extends the BookEntity class and includes fields for book ID, title, authors, image URL, and summary.
@HiveType(typeId: 0)
class BookModel extends BookEntity {
  @HiveField(0)
  final int bookId;

  @HiveField(1)
  final String bookTitle;

  @HiveField(2)
  final List<String> bookAuthors;

  @HiveField(3)
  final String? bookImageUrl;

  @HiveField(4)
  final String? bookSummary;

  BookModel({
    required this.bookId,
    required this.bookTitle,
    required this.bookAuthors,
    this.bookImageUrl,
    this.bookSummary,
  }) : super(
         id: bookId,
         title: bookTitle,
         authors: bookAuthors,
         imageUrl: bookImageUrl,
         summary: bookSummary,
       );

  factory BookModel.fromJson(Map<String, dynamic> json) {
    final authors =
        (json['authors'] as List).map((a) => a['name'] as String).toList();

    final imageUrl = json['formats']['image/jpeg'] as String?;

    final summaries = json['summaries'] as List<dynamic>?;
    final summary =
        summaries != null && summaries.isNotEmpty
            ? summaries.first.toString()
            : null;

    return BookModel(
      bookId: json['id'],
      bookTitle: json['title'],
      bookAuthors: authors,
      bookImageUrl: imageUrl,
      bookSummary: summary,
    );
  }
}
