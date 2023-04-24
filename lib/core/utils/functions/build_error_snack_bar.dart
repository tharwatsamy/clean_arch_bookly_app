import 'package:flutter/material.dart';

import '../../../Features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';

SnackBar buildErrorWidget(String errMessage) {
  return SnackBar(
    content: Text(
      errMessage,
      style: const TextStyle(),
    ),
    duration: const Duration(seconds: 3),
  );
}
