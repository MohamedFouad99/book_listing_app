import 'core/constants/constants.dart';
import 'features/book_listing/data/datasources/book_local_data_source.dart';
import 'features/book_listing/data/datasources/book_remote_data_source.dart';
import 'features/book_listing/data/repositories/book_repository_impl.dart';
import 'features/book_listing/domain/usecases/get_books_use_case.dart';
import 'features/book_listing/domain/usecases/search_books_use_case.dart';
import 'features/book_listing/presentation/cubit/book_cubit.dart';
import 'features/book_listing/presentation/ui/pages/book_list_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/book_listing/data/models/book_model.dart';

// date: 25 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the main entry point of the application.
// It initializes the Hive database, registers the BookModel adapter.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapter
  Hive.registerAdapter(BookModelAdapter());

  // Open box
  await Hive.openBox<BookModel>(Constants.booksBoxName);
  runApp(const BookListingApp());
}

// This file contains the BookListingApp widget which is the root widget of the application.
class BookListingApp extends StatelessWidget {
  const BookListingApp({super.key});

  @override
  /// This function builds the UI for the application.
  /// It registers the remote and local data sources, creates the repository,
  /// and uses the [GetBooksUseCase] and [SearchBooksUseCase] to create the
  /// [BookCubit].
  /// It uses the [ScreenUtilInit] widget to initialize the screen util package
  /// and set the design size of the application.
  /// Finally, it returns a [MaterialApp] widget with the [BookListPage] as its
  /// home page.
  Widget build(BuildContext context) {
    final dio = Dio();
    final booksBox = Hive.box<BookModel>(Constants.booksBoxName);

    final remoteDataSource = BookRemoteDataSource(dio);
    final localDataSource = BookLocalDataSource(booksBox);
    final repository = BookRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
    );
    final getBooksUseCase = GetBooksUseCase(repository);
    final searchBooksUseCase = SearchBooksUseCase(repository);
    bool isTablet = MediaQuery.of(context).size.width > 600;
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (_) => BookCubit(
                getBooksUseCase: getBooksUseCase,
                searchBooksUseCase: searchBooksUseCase,
              ),
        ),
      ],

      // Initialize ScreenUtil for responsive design
      // Set design size based on device type (tablet or phone) and orientation.
      child: ScreenUtilInit(
        designSize:
            isTablet
                ? (isLandscape ? const Size(1024, 800) : const Size(768, 1024))
                : isLandscape
                ? const Size(812, 900)
                : const Size(375, 812),
        minTextAdapt: true,
        // splitScreenMode: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const BookListPage(),
        ),
      ),
    );
  }
}
