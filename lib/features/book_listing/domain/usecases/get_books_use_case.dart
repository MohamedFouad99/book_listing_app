import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/book_entity.dart';
import '../repositories/book_repository.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the GetBooksUseCase class which is a use case for fetching books.
class GetBooksUseCase {
  final BookRepository repository;

  GetBooksUseCase(this.repository);

  /// Fetches a list of books for the given page number.
  ///
  /// The [page] parameter specifies the page number of the books to be fetched.
  /// The default value is 1.
  ///
  /// Returns either a [Failure] if an error occurred or a list of [BookEntity] objects.

  Future<Either<Failure, List<BookEntity>>> call({int page = 1}) {
    return repository.getBooks(page: page);
  }
}
