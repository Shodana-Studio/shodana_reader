import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'internet_book_details_screen_mobile.dart';

class InternetBookDetailsScreen extends StatelessWidget {
  const InternetBookDetailsScreen({Key? key, required this.internetBook, required this.rootContext}) : super(key: key);
  final Map<String, String> internetBook;
  final BuildContext rootContext;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => InternetBookDetailsScreenMobile(
          internetBook: internetBook,
      ),
      tablet: (BuildContext context) => InternetBookDetailsScreenMobile(
        internetBook: internetBook,
      ),
      desktop: (BuildContext context) => InternetBookDetailsScreenMobile(
        internetBook: internetBook,
      ),
      watch: (BuildContext context) => InternetBookDetailsScreenMobile(
        internetBook: internetBook,
      ),
    );
  }
}