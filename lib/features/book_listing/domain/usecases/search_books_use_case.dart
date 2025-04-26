import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/book_entity.dart';
import '../repositories/book_repository.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the SearchBooksUseCase class which is a use case for searching books.
class SearchBooksUseCase {
  final BookRepository repository;

  SearchBooksUseCase(this.repository);

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
  Future<Either<Failure, List<BookEntity>>> call(String query, {int page = 1}) {
    return repository.searchBooks(query, page: page);
  }
}
