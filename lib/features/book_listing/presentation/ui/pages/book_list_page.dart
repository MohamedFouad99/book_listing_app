import '../widgets/search_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theming/colors.dart';
import '../../cubit/book_cubit.dart';
import '../../cubit/book_state.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/book_list.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the BookListPage widget which is the main page for displaying a list of books.
// It includes a search field and a list of books that can be scrolled through.
// The page also handles the search functionality and pagination for loading more books as the user scrolls down.
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
  /// Initializes the state of the BookListPage widget.
  ///
  /// Calls the `fetchBooks` method of the BookCubit to load the initial list of books.
  /// Adds a listener to the scroll controller to detect when the user scrolls to the
  /// bottom of the list, triggering pagination and loading more books.
  void initState() {
    super.initState();
    _cubit.fetchBooks();
    _scrollController.addListener(_onScroll);
  }

  /// Detects when the user scrolls to the bottom of the list of books and
  /// triggers the pagination to load more books.
  ///
  /// Checks if the user has scrolled to a certain threshold (100 pixels) from
  /// the bottom of the list. If the user has scrolled to the bottom and the
  /// state of the BookCubit is BookSuccess, it calls the `fetchBooks` method
  /// to load more books.
  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      if (_cubit.state is BookSuccess) {
        _cubit.fetchBooks();
      }
    }
  }

  /// Handles the search functionality for books based on user input.
  ///
  /// If the [value] is an empty string, it calls the `clearSearch` method to reset the search.
  /// Otherwise, it calls the `searchBooks` method with the provided [value] to search for books
  /// matching the query.

  void _onSearch(String value) {
    if (value.isEmpty) {
      _cubit.clearSearch();
    } else {
      _cubit.searchBooks(value);
    }
  }

  @override
  /// Releases the resources used by the [_scrollController] and [_searchController].
  ///
  /// Calls [dispose] on both controllers and then calls [super.dispose] to
  /// release any resources used by the widget.
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  /// Builds the main UI for the Book List page.
  ///
  /// The widget consists of a [Scaffold] with a white background color.
  /// It contains an [AppBarWidget] at the top and a [Column] widget as the body.
  /// The column includes a [SearchField] for searching books and a [BookList]
  /// widget that is wrapped in an [Expanded] widget to fill the available space.
  /// The [SearchField] uses [_searchController] for managing the text input,
  /// and the search functionality is handled by [_onSearch].
  /// The [BookList] is controlled by [_scrollController] to manage the scroll position.
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
