import '../../../../../core/theming/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/colors.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the BookSummary widget which is used to
// display a summary of a book with a toggle button to expand or collapse the summary.
class BookSummary extends StatelessWidget {
  final String summary;
  final bool expanded;
  final VoidCallback onToggle;

  const BookSummary({
    super.key,
    required this.summary,
    required this.expanded,
    required this.onToggle,
  });

  @override
  /// Builds the BookSummary widget.
  ///
  /// The widget consists of a [Column] widget with a [Text] widget
  /// that displays the book's summary. The summary is displayed in
  /// a single line if the summary is short enough. If the summary is
  /// long, it is displayed in multiple lines with an ellipsis at the
  /// end. The widget also includes a [TextButton] that toggles the
  /// summary's expanded state. If the summary is expanded, the button
  /// displays "See Less", otherwise it displays "See More".
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Text(
            summary,
            style: TextStyles.font12DarkBlueRegular,
            maxLines: expanded ? null : 3,
            overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
        ),
        TextButton(
          onPressed: onToggle,
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.only(top: 4.h),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            expanded ? 'See Less' : 'See More',
            style: TextStyles.font12DarkBlueBold.copyWith(
              color: ColorsManager.blue,
            ),
          ),
        ),
      ],
    );
  }
}
