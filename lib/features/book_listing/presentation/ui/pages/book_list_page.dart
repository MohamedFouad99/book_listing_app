import 'package:book_listing_app/core/widgets/app_text_form_field.dart';
import 'package:book_listing_app/features/book_listing/presentation/ui/widgets/book_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../domain/entities/book_entity.dart';
import '../../cubit/book_cubit.dart';
import '../../cubit/book_state.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<BookCubit>().fetchBooks();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 100 &&
          context.read<BookCubit>().state is BookSuccess) {
        context.read<BookCubit>().fetchBooks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.h),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          child: CustomAppBar(title: 'Book Listing', hasBackButton: false),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: AppTextFormField(
              hintText: 'search by title or author',
              validator: (value) {},
              onChanged: (value) {},
              controller: _searchController,
              onFieldSubmitted: (value) {
                if (value.isEmpty) {
                  context.read<BookCubit>().clearSearch();
                } else {
                  context.read<BookCubit>().searchBooks(value);
                }
              },
              keyboardType: TextInputType.text,
              prefixIcon: IconButton(
                onPressed: () {
                  if (_searchController.text.isEmpty) {
                    context.read<BookCubit>().clearSearch();
                  } else {
                    context.read<BookCubit>().searchBooks(
                      _searchController.text,
                    );
                  }
                },
                icon: const Icon(Icons.search),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  _searchController.clear();
                  context.read<BookCubit>().clearSearch();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),

          Expanded(
            child: BlocBuilder<BookCubit, BookState>(
              builder: (context, state) {
                List<BookEntity> books = [];

                if (state is BookLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is BookFailure) {
                  return Center(child: Text(state.message));
                }

                if (state is BookSuccess) {
                  books = state.books;
                } else if (state is BookPaginationLoading) {
                  books = state.oldBooks;
                }

                if (books.isEmpty) {
                  return const Center(child: Text("No books found."));
                }

                return ListView.builder(
                  controller: _scrollController,
                  itemCount: books.length + 1, // Always add loader space
                  itemBuilder: (context, index) {
                    if (index < books.length) {
                      return BookListItem(book: books[index]);
                    } else {
                      return (state is BookPaginationLoading)
                          ? const Padding(
                            padding: EdgeInsets.all(8),
                            child: Center(child: CircularProgressIndicator()),
                          )
                          : const SizedBox();
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
