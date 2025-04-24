import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/book_entity.dart';
import '../repositories/book_repository.dart';

class GetBooksUseCase {
  final BookRepository repository;

  GetBooksUseCase(this.repository);

  Future<Either<Failure, List<BookEntity>>> call({int page = 1}) {
    return repository.getBooks(page: page);
  }
}
