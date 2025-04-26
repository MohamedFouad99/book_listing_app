import 'package:book_listing_app/features/book_listing/presentation/ui/widgets/search_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:book_listing_app/core/theming/colors.dart';

import 'package:book_listing_app/features/book_listing/presentation/cubit/book_cubit.dart';
import 'package:book_listing_app/features/book_listing/presentation/cubit/book_state.dart';

import '../widgets/app_bar_widget.dart';
import '../widgets/book_list.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  BookCubit get _cubit => context.read<BookCubit>();

  @override
  void initState() {
    super.initState();
    _cubit.fetchBooks();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      if (_cubit.state is BookSuccess) {
        _cubit.fetchBooks();
      }
    }
  }

  void _onSearch(String value) {
    if (value.isEmpty) {
      _cubit.clearSearch();
    } else {
      _cubit.searchBooks(value);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.white,
      appBar: const AppBarWidget(),
      body: Column(
        children: [
          SearchField(
            controller: _searchController,
            onSearch: _onSearch,
            onClear: () {
              _searchController.clear();
              _cubit.clearSearch();
            },
          ),
          Expanded(child: BookList(scrollController: _scrollController)),
        ],
      ),
    );
  }
}
