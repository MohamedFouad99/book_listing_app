import 'package:dartz/dartz.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/book_repository.dart';
import '../../../../../core/errors/failure.dart';
import '../datasources/book_remote_data_source.dart';
import '../datasources/book_local_data_source.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;
  final BookLocalDataSource localDataSource;

  BookRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
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
