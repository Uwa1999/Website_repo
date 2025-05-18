import 'package:flutter/material.dart';

import '../values/colors.dart';

class AnimatedGradientText extends StatelessWidget {
  final Animation<double> animation;
  final String text;
  final double fontSize;

  const AnimatedGradientText({
    Key? key,
    required this.animation,
    required this.text,
    this.fontSize = 45,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: const [
                AppColors.white,
                Colors.deepOrange,
                AppColors.maroon03,
              ],
              stops: [
                (animation.value - 0.3).clamp(0.0, 1.0),
                animation.value,
                (animation.value + 0.3).clamp(0.0, 1.0),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds);
          },
          child: Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              color: Colors.white,
              shadows: const [
                Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 3.0,
                  color: AppColors.maroon01,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
