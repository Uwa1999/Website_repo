import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';

import 'animated_line_through.dart';
import 'buttons/animated_nimbus_button.dart';

class InsightsData {
  final String category;
  final String date;
  final String title;
  final String subtitle;
  final String buttonText;
  final String imageUrl;

  InsightsData({
    required this.category,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.buttonText,
    required this.imageUrl,
  });
}

class InsightsCard extends StatefulWidget {
  InsightsCard({
    required this.category,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.buttonText,
    required this.imageUrl,
    this.dateStyle,
    this.titleStyle,
    this.categoryStyle,
    this.buttonTextStyle,
    this.width,
    this.imageWidth,
    this.imageHeight,
    this.buttonColor = AppColors.maroon03,
    this.buttonIcon = Icons.chevron_right,
    this.dateIcon = Icons.date_range,
    this.onPressed,
  });

  final String category;
  final String date;
  final String title;
  final String subtitle;
  final String buttonText;
  final String imageUrl;
  final double? width;
  final double? imageWidth;
  final double? imageHeight;
  final TextStyle? dateStyle;
  final TextStyle? titleStyle;
  final TextStyle? categoryStyle;
  final TextStyle? buttonTextStyle;
  final IconData dateIcon;
  final IconData buttonIcon;
  final Color buttonColor;
  final VoidCallback? onPressed;

  @override
  _InsightsCardState createState() => _InsightsCardState();
}

class _InsightsCardState extends State<InsightsCard> {
  bool _isHoveringOnImage = false;

  Color startValue = Colors.black.withOpacity(0.5);
  Color targetValue = Colors.black.withOpacity(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      width: widget.width,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(left: Sizes.MARGIN_18),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Sizes.RADIUS_16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      MouseRegion(
                        onEnter: (e) => _onImageHover(true),
                        onExit: (e) => _onImageHover(false),
                        child: AnimatedOpacity(
                          opacity: _isHoveringOnImage ? 1.0 : 0.85,
                          duration: Duration(milliseconds: 300),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(
                              Radius.circular(Sizes.RADIUS_16),
                            ),
                            child: Image.asset(
                              widget.imageUrl,
                              height: heightOfImage(),
                              width: widthOfImage(),
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: Sizes.MARGIN_30),
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.PADDING_8,
                  vertical: Sizes.PADDING_8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.maroon450,
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                ),
                child: Text(
                  widget.category,
                  style: widget.categoryStyle ??
                      textTheme.headlineSmall?.copyWith(
                        fontSize: Sizes.TEXT_SIZE_15,
                        color: AppColors.white,
                      ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(left: Sizes.MARGIN_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBoxH8(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      widget.dateIcon,
                      color: AppColors.maroon04,
                    ),
                    SizedBoxW8(),
                    Text(
                      widget.date,
                      style: widget.dateStyle ?? textTheme.titleLarge,
                    )
                  ],
                ),
                SizedBoxH8(),
                Text(
                  widget.title,
                  style: widget.dateStyle ?? textTheme.headlineSmall,
                ),
                AnimatedLineThrough(
                  text: widget.subtitle,
                  textStyle: widget.titleStyle ?? textTheme.bodyMedium,
                ),
                SizedBoxH16(),
                AnimatedNimbusButton(
                  title: widget.buttonText,
                  iconData: Icons.arrow_forward_ios,
                  leadingButtonColor: widget.buttonColor,
                  onTap: widget.onPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onImageHover(bool hovering) {
    setState(() {
      _isHoveringOnImage = hovering;
    });
  }

  double heightOfImage() {
    return widget.imageHeight ?? assignHeight(context, 0.5);
  }

  double widthOfImage() {
    return widget.imageWidth ?? widthOfScreen(context);
  }
}
