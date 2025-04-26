import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';
import '../theming/style.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the AppTextFormField widget which is a custom text form field used in the application.
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
  /// Build a [TextFormField] widget with some default styling.
  ///
  /// The widget is created with a dense layout and a rounded border.
  /// The border width is 1.3, the border radius is 8.
  /// The filled color is white.
  /// The hint text style is [TextStyles.font14DarkGreyRegular].
  /// The suffix and prefix icons are positioned at the end of the text field.
  /// The text field is obscure by default.
  /// The validator function is passed to the [TextFormField.validator] property.
  /// The [TextFormField.onChanged] property is set to the [onChanged] function.
  /// The [TextFormField.onFieldSubmitted] property is set to the [onFieldSubmitted] function.
  /// The [TextFormField.keyboardType] property is set to the [keyboardType] parameter.
  /// The [TextFormField.readOnly] property is set to the [readOnly] parameter.
  /// The [TextFormField.maxLines] property is set to the [maxLines] parameter or 1 if it is null.
  /// The [TextFormField.initialValue] property is set to the [initialValue] parameter.
  /// The [TextFormField.controller] property is set to the [controller] parameter.
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
