import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theming/colors.dart';
import '../../../../../core/widgets/app_text_form_field.dart';

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
