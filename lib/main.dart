import 'package:book_listing_app/features/book_listing/data/datasources/book_local_data_source.dart';
import 'package:book_listing_app/features/book_listing/data/datasources/book_remote_data_source.dart';
import 'package:book_listing_app/features/book_listing/data/repositories/book_repository_impl.dart';
import 'package:book_listing_app/features/book_listing/domain/usecases/get_books_use_case.dart';
import 'package:book_listing_app/features/book_listing/domain/usecases/search_books_use_case.dart';
import 'package:book_listing_app/features/book_listing/presentation/cubit/book_cubit.dart';
import 'package:book_listing_app/features/book_listing/presentation/ui/pages/book_list_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/book_listing/data/models/book_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapter
  Hive.registerAdapter(BookModelAdapter());

  // Open box
  await Hive.openBox<BookModel>('booksBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final booksBox = Hive.box<BookModel>('booksBox');

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
          title: 'Book Listing App',
          theme: ThemeData(primarySwatch: Colors.indigo),
          home: const BookListPage(),
        ),
      ),
    );
  }
}
