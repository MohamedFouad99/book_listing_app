import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theming/colors.dart';
import '../theming/style.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLines;
  final String? initialValue;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final Function(String?) validator;
  final void Function(String) onChanged;
  final void Function(String)? onFieldSubmitted;
  final TextInputType keyboardType;
  final bool readOnly;
  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    this.maxLines,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.backgroundColor,
    this.controller,
    this.initialValue,
    required this.validator,
    required this.onChanged,
    this.onFieldSubmitted,
    required this.keyboardType,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      initialValue: initialValue,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            contentPadding ?? EdgeInsets.symmetric(horizontal: 20.w),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.blue,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(
                color: ColorsManager.darkGray,
                width: 1.3,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        hintStyle: hintStyle ?? TextStyles.font14DarkGreyRegular,
        hintText: hintText,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        fillColor: backgroundColor ?? ColorsManager.white,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: TextStyles.font14GreyRegular,
      validator: (value) {
        return validator(value);
      },
    );
  }
}
