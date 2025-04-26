import 'package:equatable/equatable.dart';
import '../../domain/entities/book_entity.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the BookState class which represents the state of the book listing feature.
abstract class BookState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// The initial state of the book listing feature.
class BookInitial extends BookState {}

/// Full screen loading (First page)
class BookLoading extends BookState {}

/// The loading state of the book listing feature for pagination.
/// This state is used when loading more books while scrolling.
class BookPaginationLoading extends BookState {
  final List<BookEntity> oldBooks;
  final bool isFirstFetch;

  BookPaginationLoading(this.oldBooks, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldBooks, isFirstFetch];
}

/// This state is used when books are successfully fetched from the API.
class BookSuccess extends BookState {
  final List<BookEntity> books;
  final bool hasMore;
  final int currentPage;

  BookSuccess({
    required this.books,
    required this.hasMore,
    required this.currentPage,
  });

  @override
  List<Object?> get props => [books, hasMore, currentPage];
}

/// This state is used when there is an error while fetching books from the API.
class BookFailure extends BookState {
  final String message;

  BookFailure(this.message);

  @override
  List<Object?> get props => [message];
}
