import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/book_entity.dart';

abstract class BookRepository {
  Future<Either<Failure, List<BookEntity>>> getBooks({int page});
  Future<Either<Failure, List<BookEntity>>> searchBooks(
    String query, {
    int page,
  });
}
