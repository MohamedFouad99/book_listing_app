import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/app_text_form_field.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the SearchField widget which is used for searching books by title or author.
class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final VoidCallback onClear;

  const SearchField({
    super.key,
    required this.controller,
    required this.onSearch,
    required this.onClear,
  });

  @override
  /// Builds the SearchField widget wrapped in padding.
  ///
  /// This widget provides a text input field for searching books by title or author.
  /// It uses [AppTextFormField] with a search and clear icon, which are used to trigger
  /// the search and clear actions respectively.
  ///
  /// The [controller] manages the text input, and the [onSearch] callback is triggered
  /// when the search icon is pressed or when the text is submitted.
  /// The [onClear] callback is triggered when the clear icon is pressed.
  ///
  /// The text input field is styled with a prefix icon for search and a suffix icon for clear.
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: AppTextFormField(
        hintText: 'Search by title or author',
        validator: (value) {},
        controller: controller,
        onChanged: (value) {},
        onFieldSubmitted: onSearch,
        keyboardType: TextInputType.text,
        prefixIcon: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => onSearch(controller.text),
          icon: const Icon(Icons.search, color: ColorsManager.secondary),
        ),
        suffixIcon: IconButton(
          padding: EdgeInsets.zero,
          onPressed: onClear,
          icon: const Icon(Icons.clear, color: ColorsManager.primary),
        ),
      ),
    );
  }
}
