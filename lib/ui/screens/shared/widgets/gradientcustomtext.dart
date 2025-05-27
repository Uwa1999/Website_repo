import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientCustomText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientCustomText({
    Key? key,
    required this.text,
    required this.style,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = gradient.colors;

    return Stack(
      alignment: Alignment.center,
      children: [
        // Very light, thin glow effect
        ...colors.map((color) {
          return Text(
            text,
            style: style.copyWith(
              foreground: Paint()..color = color.withOpacity(0.06), // Thin glow
              shadows: [
                Shadow(
                  blurRadius: 6, // Less blur
                  color: color.withOpacity(0.08), // Very subtle
                  offset: Offset(0, 0),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          );
        }).toList(),
        // Main gradient text
        ShaderMask(
          shaderCallback: (bounds) {
            return gradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            );
          },
          child: Text(
            text,
            style: style.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

Gradient linearGradient = const LinearGradient(
  colors: [
    Color(0xFF000000), // Black
    Color(0xFF000000),
    Color(0xFF4B0C0C), // Dark maroon-ish
    Color(0xFFD43232), // Red
    Color(0xFFFF6B6B), // Light red/pinkish
    Color(0xFFFF6B6B), // White (optional for fade)
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);