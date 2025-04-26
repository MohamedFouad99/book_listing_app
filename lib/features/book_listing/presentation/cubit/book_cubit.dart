import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/usecases/get_books_use_case.dart';
import '../../domain/usecases/search_books_use_case.dart';
import 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  final GetBooksUseCase getBooksUseCase;
  final SearchBooksUseCase searchBooksUseCase;

  List<BookEntity> _allBooks = [];
  int _currentPage = 1;
  bool _hasMore = true;
  String? _currentQuery;

  BookCubit({required this.getBooksUseCase, required this.searchBooksUseCase})
    : super(BookInitial());

  void fetchBooks() async {
    if (!_hasMore) return;

    final isFirstPage = _currentPage == 1;

    if (isFirstPage) {
      emit(BookLoading()); // full screen loader
    } else {
      emit(BookPaginationLoading(_allBooks)); // bottom loader
    }

    final result =
        _currentQuery == null
            ? await getBooksUseCase(page: _currentPage)
            : await searchBooksUseCase(_currentQuery!, page: _currentPage);

    result.fold((failure) => emit(BookFailure(failure.message)), (books) {
      if (_currentPage == 1) {
        _allBooks = books;
      } else {
        _allBooks.addAll(
          books.where((book) => !_allBooks.any((b) => b.id == book.id)),
        );
      }

      _hasMore = books.length == 32;

      emit(
        BookSuccess(
          books: _allBooks,
          hasMore: _hasMore,
          currentPage: _currentPage,
        ),
      );

      _currentPage++;
    });
  }

  void searchBooks(String query) {
    _currentQuery = query;
    _currentPage = 1;
    _allBooks.clear();
    _hasMore = true;
    fetchBooks();
  }

  void clearSearch() {
    _currentQuery = null;
    _currentPage = 1;
    _allBooks.clear();
    _hasMore = true;
    fetchBooks();
  }
}
