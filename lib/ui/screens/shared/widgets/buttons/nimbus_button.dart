import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

class NimbusButton extends StatelessWidget {
  NimbusButton({
    required this.buttonTitle,
    this.width = Sizes.WIDTH_150,
    this.height = Sizes.HEIGHT_60,
    this.titleStyle,
    this.titleColor = AppColors.white,
    this.buttonColor = AppColors.maroon03,
    this.onPressed,
    this.padding = const EdgeInsets.all(Sizes.PADDING_8),
    this.borderRadius = const BorderRadius.all(
      Radius.circular(Sizes.RADIUS_10),
    ),
    this.opensUrl = false,
    this.url = "",
    this.linkTarget = LinkTarget.blank,
  });

  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final String buttonTitle;
  final TextStyle? titleStyle;
  final Color titleColor;
  final Color buttonColor;

  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry padding;
  final String url;
  final LinkTarget linkTarget;
  final bool opensUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: MaterialButton(
        minWidth: width,
        height: height,
        onPressed: opensUrl ? () {} : onPressed,
        color: buttonColor,
        child: Padding(
          padding: padding,
          child: buildChild(context),
        ),
      ),
    );
  }

  Widget buildChild(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double textSize = responsiveSize(
      context,
      Sizes.TEXT_SIZE_14,
      Sizes.TEXT_SIZE_16,
      md: Sizes.TEXT_SIZE_15,
    );
    if (opensUrl) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Link(
          uri: Uri.parse(url),
          target: linkTarget,
          builder: (context, followLink) {
            return GestureDetector(
              onTap: followLink,
              child: Row(
                children: [
                  // Icon(
                  //   Icons.arrow_downward_outlined,
                  //   color: Colors.white,
                  // ),
                  // SpaceW5(),
                  Text(
                    buttonTitle,
                    style: titleStyle ??
                        textTheme.bodyMedium?.copyWith(
                          color: titleColor,
                          fontSize: textSize,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else {
      return Text(
        buttonTitle,
        style: titleStyle ??
            textTheme.bodyMedium?.copyWith(
              color: titleColor,
              fontSize: textSize,
              letterSpacing: 1.1,
              fontWeight: FontWeight.bold,
            ),
      );
    }
  }
}
