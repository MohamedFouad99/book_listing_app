import 'package:hive/hive.dart';
import '../models/book_model.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the BookLocalDataSource class which is a data source for the book listing feature.
class BookLocalDataSource {
  final Box<BookModel> box;

  BookLocalDataSource(this.box);

  /// [clearBeforeSave] parameter is useful when you want to clear the cache before saving new data.
  /// If [clearBeforeSave] is true, the method will clear the cache before saving new data.
  /// If [clearBeforeSave] is false, the method will append new data to the cache.
  ///
  /// [books] parameter is the list of books to be cached.
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
  ///
  /// Returns null if the cache is empty.
  List<BookModel>? getCachedBooks() {
    final books = box.values.toList();
    return books.isEmpty ? null : books;
  }

  /// Search cached books by query
  ///
  /// [query] parameter is the search query.
  ///
  /// Returns a list of books whose title or author contains the query in a case-insensitive manner.

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
