import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';

class TextWithBullet extends StatelessWidget {
  TextWithBullet({
    required this.text,
    this.textStyle,
    this.spacing,
  });

  final String text;
  final TextStyle? textStyle;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Bullet(),
        spacing == null ? SizedBoxW16() : SizedBox(width: spacing),
        Text(
          text,
          style: textStyle ??
              textTheme.bodyLarge?.copyWith(
                color: AppColors.primaryText2,
              ),
        ),
      ],
    );
  }
}

class Bullet extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final Color color;

  Bullet({
    this.width = 4.0,
    this.height = 4.0,
    this.borderRadius = 20,
    this.color = AppColors.maroon450,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
    );
  }
}
