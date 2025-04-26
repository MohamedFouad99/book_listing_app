import 'package:book_listing_app/core/theming/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/colors.dart';

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
