import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_app_bar.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the AppBarWidget widget which is a custom app bar used in the book listing feature.
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key});

  @override
  Size get preferredSize => Size.fromHeight(80.h);

  @override
  /// Builds the AppBarWidget widget.
  //
  /// This widget is a custom app bar used in the book listing feature.
  //
  /// It takes no parameters and returns a ClipRRect widget with a rounded
  /// bottom edge and a child of a CustomAppBar widget with the title 'Book
  /// Listing'.
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      child: const CustomAppBar(title: 'Book Listing'),
    );
  }
}
