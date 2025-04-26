import 'package:equatable/equatable.dart';
import '../../domain/entities/book_entity.dart';

abstract class BookState extends Equatable {
  @override
  List<Object?> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {} // Full screen loading (First page)

class BookPaginationLoading extends BookState {
  final List<BookEntity> oldBooks;
  final bool isFirstFetch;

  BookPaginationLoading(this.oldBooks, {this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldBooks, isFirstFetch];
}

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

class BookFailure extends BookState {
  final String message;

  BookFailure(this.message);

  @override
  List<Object?> get props => [message];
}
