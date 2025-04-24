import 'package:hive/hive.dart';
import '../models/book_model.dart';

class BookLocalDataSource {
  final Box box;

  BookLocalDataSource(this.box);

  Future<void> cacheBooks({
    required List<BookModel> books,
    required int page,
    String? query,
  }) async {
    final key = _generateKey(page: page, query: query);
    await box.put(key, books);
  }

  List<BookModel>? getCachedBooks({required int page, String? query}) {
    final key = _generateKey(page: page, query: query);
    final result = box.get(key);

    if (result is List<dynamic>) {
      return result.cast<BookModel>();
    }

    return null;
  }

  String _generateKey({required int page, String? query}) {
    return query != null && query.isNotEmpty
        ? 'search_${query}_page_$page'
        : 'page_$page';
  }
}
