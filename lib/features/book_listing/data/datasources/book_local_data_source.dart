import 'package:hive/hive.dart';
import '../models/book_model.dart';

class BookLocalDataSource {
  final Box<BookModel> box;

  BookLocalDataSource(this.box);

  /// Cache all books (override if refreshing, append if loading more)
  Future<void> cacheBooks({
    required List<BookModel> books,
    bool clearBeforeSave = false,
  }) async {
    if (clearBeforeSave) {
      await box.clear();
    }
    await box.addAll(books);
  }

  /// Retrieve all cached books (used for fallback on error)
  List<BookModel>? getCachedBooks() {
    final books = box.values.toList();
    return books.isEmpty ? null : books;
  }

  List<BookModel> searchCachedBooks(String query) {
    final normalizedQuery = query.trim().toLowerCase();
    final allBooks = box.values.toList();

    return allBooks.where((book) {
      final titleMatch = book.title.toLowerCase().contains(normalizedQuery);
      final authorMatch = book.authors.any(
        (a) => a.toLowerCase().contains(normalizedQuery),
      );
      return titleMatch || authorMatch;
    }).toList();
  }
}
