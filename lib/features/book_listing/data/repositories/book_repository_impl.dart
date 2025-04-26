import 'package:dartz/dartz.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/book_repository.dart';
import '../../../../../core/errors/failure.dart';
import '../datasources/book_remote_data_source.dart';
import '../datasources/book_local_data_source.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the BookRepositoryImpl class which implements
// the BookRepository interface and provides methods to fetch and search books.
class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;
  final BookLocalDataSource localDataSource;

  BookRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  /// Fetches books from the API and caches them.
  ///
  /// If the fetching process fails, it returns the cached books if available.
  ///
  /// If the fetching process succeeds, it caches the fetched books and returns them.
  ///
  /// [page] parameter is the page number of the books to be fetched.
  /// Default value is 1.
  Future<Either<Failure, List<BookEntity>>> getBooks({int page = 1}) async {
    final result = await remoteDataSource.fetchBooks(page: page);

    return result.fold(
      (failure) {
        final cached = localDataSource.getCachedBooks();
        if (cached != null) {
          return right(cached);
        } else {
          return left(failure);
        }
      },
      (books) async {
        await localDataSource.cacheBooks(
          books: books,
          clearBeforeSave: page == 1,
        );
        return right(books);
      },
    );
  }

  @override
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
    int page = 1,
  }) async {
    final result = await remoteDataSource.fetchBooks(query: query, page: page);

    return result.fold(
      (failure) {
        final cached = localDataSource.searchCachedBooks(query);
        if (cached.isNotEmpty) {
          return right(cached);
        } else {
          return left(failure);
        }
      },
      (books) async {
        await localDataSource.cacheBooks(
          books: books,
          clearBeforeSave: page == 1,
        );
        return right(books);
      },
    );
  }
}
