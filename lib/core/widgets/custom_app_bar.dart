import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';
import '../theming/style.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the CustomAppBar widget which is a reusable app bar used throughout the application.
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, required this.title});
  final String title;

  @override
  /// Builds the CustomAppBar widget.
  ///
  /// This widget is a reusable app bar used throughout the application.
  ///
  /// It takes a title and returns an AppBar widget with that title.
  ///
  /// The AppBar widget has a black background color and white bold text.
  /// The title is centered in the app bar.
  /// The leading widget (usually a back button) is null.
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 110.h,
      backgroundColor: ColorsManager.primary,
      title: Text(title, style: TextStyles.font204WhiteBold),
      centerTitle: true,
      leading: null,
    );
  }
}
