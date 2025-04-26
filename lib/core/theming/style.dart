import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'colors.dart';
import 'font_weight_helper.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the TextStyles class which defines the text styles used in the application.
class TextStyles {
  static String fontFamily = 'Almarai';
  static TextStyle font204WhiteBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.white,
  );

  static TextStyle font12DarkBlueBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.darkBlue,
  );
  static TextStyle font12DarkBlueRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.darkBlue,
  );

  static TextStyle font16DarkBlueBold = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.darkBlue,
  );

  static TextStyle font14GreyRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.notActive,
  );
  static TextStyle font14DarkGreyRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.darkGray,
  );

  static TextStyle font12DarkGreyRegular = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.darkGray,
  );
}
