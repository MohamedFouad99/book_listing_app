import '../../../../../core/helpers/spacing.dart';
import 'book_image.dart';
import 'book_summary.dart';
import 'book_text_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/colors.dart';
import '../../../domain/entities/book_entity.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the BookListItem widget which is used to display a book's information.
class BookListItem extends StatefulWidget {
  final BookEntity book;

  const BookListItem({super.key, required this.book});

  @override
  State<BookListItem> createState() => _BookListItemState();
}

class _BookListItemState extends State<BookListItem>
    with TickerProviderStateMixin {
  bool expanded = false;

  @override
  /// Builds the BookListItem widget.
  //
  /// The widget consists of a [Container] widget with a white background color
  /// and a rounded border. The container has a margin of 12 pixels in the
  /// horizontal direction and 6 pixels in the vertical direction.
  //
  /// The child of the container is a [Column] widget with two children. The
  /// first child is a [Row] widget that contains a [BookImage] widget and
  /// a [BookTextContent] widget. The book image is displayed on the left
  /// side of the row and the book text content is displayed on the right
  /// side of the row.
  //
  /// The second child of the column is a [BookSummary] widget that displays
  /// the book's summary. The summary is only displayed if the book has a
  /// summary and the summary is not empty. The summary is displayed in an
  /// expanded state if the [expanded] variable is set to true.
  //
  /// The [onToggle] callback is called when the user taps on the expand
  /// button. The callback toggles the [expanded] variable.
  //
  /// The [BookSummary] widget also has a [onToggle] callback which is called
  /// when the user taps on the expand button. The callback toggles the
  /// [expanded] variable.
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: ColorsManager.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.gray,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BookImage(imageUrl: widget.book.imageUrl),
              horizontalSpace(12),
              Expanded(
                child: BookTextContent(
                  title: widget.book.title,
                  authors: widget.book.authors,
                ),
              ),
            ],
          ),
          if (widget.book.summary != null && widget.book.summary!.isNotEmpty)
            BookSummary(
              summary: widget.book.summary!,
              expanded: expanded,
              onToggle: () => setState(() => expanded = !expanded),
            ),
        ],
      ),
    );
  }
}
