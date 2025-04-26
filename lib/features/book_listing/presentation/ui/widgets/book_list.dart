import 'package:book_listing_app/core/theming/colors.dart';
import 'package:book_listing_app/features/book_listing/domain/entities/book_entity.dart';
import 'package:book_listing_app/features/book_listing/presentation/cubit/book_cubit.dart';
import 'package:book_listing_app/features/book_listing/presentation/cubit/book_state.dart';
import 'package:book_listing_app/features/book_listing/presentation/ui/widgets/book_list_item.dart';
import 'package:book_listing_app/features/book_listing/presentation/ui/widgets/lottie_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/constants/app_assets.dart';

class BookList extends StatelessWidget {
  final ScrollController scrollController;

  const BookList({super.key, required this.scrollController});

  @override
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
