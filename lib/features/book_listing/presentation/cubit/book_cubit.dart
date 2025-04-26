import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/usecases/get_books_use_case.dart';
import '../../domain/usecases/search_books_use_case.dart';
import 'book_state.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the BookCubit class which manages the state of the book listing feature.
// It handles fetching books, searching for books, and managing pagination.
class BookCubit extends Cubit<BookState> {
  final GetBooksUseCase getBooksUseCase;
  final SearchBooksUseCase searchBooksUseCase;

  List<BookEntity> _allBooks = [];
  int _currentPage = 1;
  bool _hasMore = true;
  String? _currentQuery;

  BookCubit({required this.getBooksUseCase, required this.searchBooksUseCase})
    : super(BookInitial());

  /// Fetches books from the API, caches them, and updates the state accordingly.
  ///
  /// If [BookCubit._hasMore] is false, it returns immediately.
  ///
  /// If [_currentPage] is 1, it emits [BookLoading] and fetches books.
  /// Otherwise, it emits [BookPaginationLoading] and fetches books.
  ///
  /// If the fetching process fails, it emits [BookFailure] with the error message.
  /// If the fetching process succeeds, it caches the fetched books and updates
  /// the state with the new list of books and a boolean indicating whether there
  /// are more books to fetch.
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

  /// Searches for books based on a query and fetches the first page of results.
  ///
  /// It clears the current list of books and resets the pagination.
  /// If the query is empty, it fetches the first page of all books.
  void searchBooks(String query) {
    _currentQuery = query;
    _currentPage = 1;
    _allBooks.clear();
    _hasMore = true;
    fetchBooks();
  }

  /// Clears the current search query and resets the pagination.
  ///
  /// This method sets [_currentQuery] to null and resets [_currentPage] to 1.
  /// It also clears the [_allBooks] list and sets [_hasMore] to true.
  /// Finally, it triggers a fetch of the first page of all books.

  void clearSearch() {
    _currentQuery = null;
    _currentPage = 1;
    _allBooks.clear();
    _hasMore = true;
    fetchBooks();
  }
}
