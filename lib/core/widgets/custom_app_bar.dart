import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';
import '../theming/style.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.hasBackButton = true,
  });
  final String title;
  final bool? hasBackButton;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 110.h,
      backgroundColor: ColorsManager.primary,
      title: Text(title, style: TextStyles.font204WhiteBold),
      centerTitle: true,
      leading:
          hasBackButton == false
              ? null
              : IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back, color: ColorsManager.white),
              ),
    );
  }
}
