import 'package:bookly/Features/home/data/repos/home_repo_impl.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/use_cases/fetch_featured_books_use_case.dart';
import 'package:bookly/Features/home/domain/use_cases/fetch_newest_books_use_case.dart';
import 'package:bookly/Features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly/Features/home/presentation/manger/newset_books_cubit/newest_books_cubit.dart';
import 'package:bookly/constants.dart';
import 'package:bookly/core/utils/app_router.dart';
import 'package:bookly/core/utils/simple_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

import 'core/utils/functions/setup_service_locator.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookEntityAdapter());
  setupServiceLocator();
  await Hive.openBox<BookEntity>(kFeaturedBox);
  await Hive.openBox<BookEntity>(kNewestBox);
  Bloc.observer = SimpleBlocObserver();
  runApp(const Bookly());
}

class Bookly extends StatelessWidget {
  const Bookly({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return FeaturedBooksCubit(
              FetchFeaturedBooksUseCase(
                getIt.get<HomeRepoImpl>(),
              ),
            )..fetchFeaturedBooks();
          },
        ),
        BlocProvider(
          create: (context) {
            return NewestBooksCubit(
              FetchNewestdBooksUseCase(
                getIt.get<HomeRepoImpl>(),
              ),
            );
          },
        )
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          textTheme:
              GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        ),
      ),
    );
  }
}
