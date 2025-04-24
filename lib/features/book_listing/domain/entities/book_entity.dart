// date: 25 April 2025
// by: Fouad
// last modified at: 25 April 2025
// This code defines a BookEntity class that represents a book with various attributes.
class BookEntity {
  final int id;
  final String title;
  final List<String> authors;
  final String? imageUrl;
  final String? summary;
  BookEntity({
    required this.id,
    required this.title,
    required this.authors,
    this.imageUrl,
    this.summary,
  });
}
