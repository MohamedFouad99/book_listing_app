import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/style.dart';

// date: 26 April 2025
// by: Fouad
// last modified at: 26 April 2025
// description: This file contains the LottieWidget widget which is used to display a lottie animation.
class LottieWidget extends StatelessWidget {
  const LottieWidget({super.key, required this.message, required this.gif});
  final String message;
  final String gif;

  @override
  /// Builds the UI for displaying a lottie animation with a message.
  ///
  /// The animation is centered vertically and horizontally.
  ///
  /// The message is displayed below the animation with a vertical spacing of 16 dp.
  /// The message is displayed with a font size of 16 dp and a dark blue bold style.
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(gif),
          verticalSpace(16),
          Text(message, style: TextStyles.font16DarkBlueBold),
        ],
      ),
    );
  }
}
