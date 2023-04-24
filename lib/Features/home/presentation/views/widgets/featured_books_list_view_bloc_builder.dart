import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:bookly/core/utils/functions/build_error_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'featured_list_view.dart';

class FeatuedBooksListViewBlocBuilder extends StatefulWidget {
  const FeatuedBooksListViewBlocBuilder({
    super.key,
  });

  @override
  State<FeatuedBooksListViewBlocBuilder> createState() =>
      _FeatuedBooksListViewBlocBuilderState();
}

class _FeatuedBooksListViewBlocBuilderState
    extends State<FeatuedBooksListViewBlocBuilder> {
  List<BookEntity> books = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeaturedBooksCubit, FeaturedBooksState>(
      listener: (context, state) {
        if (state is FeaturedBooksSuccess) {
          books.addAll(state.books);
        }

        if (state is FeaturedBooksPaginationFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            buildErrorWidget(state.errMessage),
          );
        }
      },
      builder: (context, state) {
        if (state is FeaturedBooksSuccess ||
            state is FeaturedBooksPaginationLoading ||
            state is FeaturedBooksPaginationFailure) {
          return FeaturedBooksListView(
            books: books,
          );
        } else if (state is FeaturedBooksFailure) {
          return Text(state.errMessage);
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
