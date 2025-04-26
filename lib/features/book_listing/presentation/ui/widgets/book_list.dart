import '../../../../../core/theming/colors.dart';
import '../../../domain/entities/book_entity.dart';
import '../../cubit/book_cubit.dart';
import '../../cubit/book_state.dart';
import 'book_list_item.dart';
import 'lottie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/app_assets.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the BookList widget which is used to display a list of books.
class BookList extends StatelessWidget {
  final ScrollController scrollController;

  const BookList({super.key, required this.scrollController});

  @override
  /// Builds the UI for displaying a list of books.
  ///
  /// Uses a [BlocBuilder] to listen to the [BookCubit] and build the UI based
  /// on the current [BookState].
  ///
  /// - Displays a loading animation while books are being loaded.
  /// - Shows an error message with an animation if the book loading fails.
  /// - Displays a list of books once the books are successfully loaded.
  /// - Shows a pagination loading indicator when more books are being fetched.
  /// - If no books are found, it displays a message indicating that no books are available.
  Widget build(BuildContext context) {
    return BlocBuilder<BookCubit, BookState>(
      builder: (context, state) {
        List<BookEntity> books = [];

        if (state is BookLoading) {
          return Center(child: Lottie.asset(AppAssets.loadingGif));
        } else if (state is BookFailure) {
          return LottieWidget(message: state.message, gif: AppAssets.emptyGif);
        } else if (state is BookSuccess) {
          books = state.books;
        } else if (state is BookPaginationLoading) {
          books = state.oldBooks;
        }

        if (books.isEmpty) {
          return LottieWidget(
            message: 'No books found',
            gif: AppAssets.emptyGif,
          );
        }

        return ListView.builder(
          controller: scrollController,
          itemCount: books.length + 1,
          itemBuilder: (context, index) {
            if (index < books.length) {
              return BookListItem(book: books[index]);
            } else {
              return (state is BookPaginationLoading)
                  ? const Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.primary,
                      ),
                    ),
                  )
                  : const SizedBox();
            }
          },
        );
      },
    );
  }
}
