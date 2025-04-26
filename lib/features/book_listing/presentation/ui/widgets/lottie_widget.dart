import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/helpers/spacing.dart';
import '../../../../../core/theming/style.dart';

class LottieWidget extends StatelessWidget {
  const LottieWidget({super.key, required this.message, required this.gif});
  final String message;
  final String gif;

  @override
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
