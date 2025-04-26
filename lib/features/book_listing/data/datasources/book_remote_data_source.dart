import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../../core/errors/failure.dart';
import '../models/book_model.dart';

class BookRemoteDataSource {
  final Dio dio;

  BookRemoteDataSource(this.dio);

  Future<Either<Failure, List<BookModel>>> fetchBooks({
    int page = 1,
    String? query,
  }) async {
    try {
      final response = await dio.get(
        'https://gutendex.com/books',
        queryParameters: {
          'page': page,
          if (query != null && query.isNotEmpty) 'search': query,
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
