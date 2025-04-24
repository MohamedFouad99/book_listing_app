import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
    try {
      final books = await remoteDataSource.fetchBooks(page: page);
      await localDataSource.cacheBooks(books: books, page: page);
      return right(books);
    } on DioException catch (e) {
      final cached = localDataSource.getCachedBooks(page: page);
      if (cached != null) return right(cached);
      return left(ServerFailure.fromDiorError(e));
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> searchBooks(
    String query, {
    int page = 1,
  }) async {
    try {
      final books = await remoteDataSource.fetchBooks(query: query, page: page);
      await localDataSource.cacheBooks(books: books, page: page, query: query);
      return right(books);
    } on DioException catch (e) {
      final cached = localDataSource.getCachedBooks(page: page, query: query);
      if (cached != null) return right(cached);
      return left(ServerFailure.fromDiorError(e));
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
