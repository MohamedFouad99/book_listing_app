import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/book_entity.dart';
import '../repositories/book_repository.dart';

class SearchBooksUseCase {
  final BookRepository repository;

  SearchBooksUseCase(this.repository);

  Future<Either<Failure, List<BookEntity>>> call(String query, {int page = 1}) {
    return repository.searchBooks(query, page: page);
  }
}
