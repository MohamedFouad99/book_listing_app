import 'package:book_listing_app/core/helpers/spacing.dart';
import 'package:book_listing_app/features/book_listing/presentation/ui/widgets/book_image.dart';
import 'package:book_listing_app/features/book_listing/presentation/ui/widgets/book_summary.dart';
import 'package:book_listing_app/features/book_listing/presentation/ui/widgets/book_text_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theming/colors.dart';
import '../../../domain/entities/book_entity.dart';

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
