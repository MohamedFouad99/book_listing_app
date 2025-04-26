import 'package:book_listing_app/core/helpers/spacing.dart';
import 'package:book_listing_app/core/theming/style.dart';
import 'package:flutter/material.dart';

class BookTextContent extends StatelessWidget {
  final String title;
  final List<String> authors;

  const BookTextContent({
    super.key,
    required this.title,
    required this.authors,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyles.font16DarkBlueBold.copyWith(height: 1.3)),
        verticalSpace(4),
        Text(authors.join(', '), style: TextStyles.font12DarkGreyRegular),
      ],
    );
  }
}
