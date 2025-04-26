import '../../../../core/constants/api_constants.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/failure.dart';
import '../models/book_model.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the BookRemoteDataSource class which is a data source for the book listing feature.
class BookRemoteDataSource {
  final Dio dio;

  BookRemoteDataSource(this.dio);

  /// Fetches a list of books from the API.
  ///
  /// If [query] is not null or empty, it is used to search for books by title.
  ///
  /// If [page] is not provided, it defaults to 1.
  ///
  /// Returns a list of [BookModel] if the request is successful, or a [Failure] if
  /// the request fails.
  Future<Either<Failure, List<BookModel>>> fetchBooks({
    int page = 1,
    String? query,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.apiBaseUrl,
        queryParameters: {
          ApiConstants.page: page,
          if (query != null && query.isNotEmpty) ApiConstants.query: query,
        },
      );

      final data = response.data['results'] as List;
      final books = data.map((json) => BookModel.fromJson(json)).toList();

      return right(books);
    } on DioException catch (e) {
      return left(ServerFailure.fromDiorError(e));
    } catch (e) {
      return left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
