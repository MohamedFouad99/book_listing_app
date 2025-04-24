import 'package:dio/dio.dart';
import '../models/book_model.dart';

class BookRemoteDataSource {
  final Dio dio;

  BookRemoteDataSource(this.dio);

  Future<List<BookModel>> fetchBooks({int page = 1, String? query}) async {
    try {
      final response = await dio.get(
        'https://gutendex.com/books',
        queryParameters: {
          'page': page,
          if (query != null && query.isNotEmpty) 'search': query,
        },
      );

      final data = response.data['results'] as List;

      return data.map((json) => BookModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch books: $e');
    }
  }
}
