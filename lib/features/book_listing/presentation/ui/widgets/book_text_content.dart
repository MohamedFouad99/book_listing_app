import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/style.dart';
import 'package:flutter/material.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the BookTextContent widget which is used to display the title and authors of a book.
class BookTextContent extends StatelessWidget {
  final String title;
  final List<String> authors;

  const BookTextContent({
    super.key,
    required this.title,
    required this.authors,
  });

  @override
  /// Builds the BookTextContent widget.
  //
  /// The widget displays the title and authors of a book in a column layout.
  /// The title is displayed in a bold dark blue font with a line height of 1.3.
  /// The authors are displayed in a regular dark grey font with a comma separated list.
  /// There is a vertical spacing of 4 between the title and authors.
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
