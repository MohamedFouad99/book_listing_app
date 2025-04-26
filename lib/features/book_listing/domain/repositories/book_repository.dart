import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/book_entity.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the BookRepository interface which defines methods for fetching and searching books.
abstract class BookRepository {
  /// Fetches books from the API and caches them.
  ///
  /// If the fetching process fails, it returns the cached books if available.
  ///
  /// If the fetching process succeeds, it caches the fetched books and returns them.
  ///
  /// [page] parameter is the page number of the books to be fetched.
  /// Default value is 1.
  ///
  /// Returns either a [Failure] or a list of [BookEntity] objects.
  Future<Either<Failure, List<BookEntity>>> getBooks({int page});

  /// Searches for books based on a query and caches the results.
  ///
  /// First attempts to fetch books from the remote data source using the provided query.
  /// If the fetching process fails, it returns cached books that match the query, if available.
  ///
  /// If the fetching process succeeds, it caches the fetched books and returns them.
  ///
  /// [query] parameter is the search term used to find books.
  /// [page] parameter is the page number of the books to be searched.
  /// Default value is 1.
  ///
  /// Returns either a [Failure] or a list of [BookEntity] objects.
  Future<Either<Failure, List<BookEntity>>> searchBooks(
    String query, {
    int page,
  });
}
