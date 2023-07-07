import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';

class InsightsData {
  final String category;
  final String date;
  final String title;
  final String subtitle;
  final String? buttonText;
  final String imageUrl;
  final VoidCallback? onPressed;

  InsightsData({
    this.onPressed,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.date,
    this.buttonText,
    required this.imageUrl,
  });
}

class InsightsCard extends StatefulWidget {
  InsightsCard({
    required this.category,
    required this.title,
    required this.subtitle,
    required this.date,
    this.buttonText,
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
  final String? buttonText;
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
  late AnimationController _slideFadeController;
  late AnimationController _indicatorController;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: 420,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Card(
                  shadowColor: AppColors.black,
                  //   margin: const EdgeInsets.only(left: Sizes.MARGIN_18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image.asset(
                        widget.imageUrl,
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: double.infinity,
                        fit: BoxFit.fitHeight,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     children: [
                      //       Icon(
                      //         widget.dateIcon,
                      //         color: AppColors.maroon04,
                      //       ),
                      //       SizedBoxW8(),
                      //       Text(
                      //         widget.date,
                      //         style: widget.dateStyle ?? textTheme.titleLarge,
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.title,
                            style: widget.dateStyle ?? textTheme.headlineSmall,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.subtitle,
                            style: widget.titleStyle ?? textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      SizedBoxH10(),
                    ],
                  ),
                ),

                //Insights Label
                Container(
                  margin: const EdgeInsets.only(top: Sizes.MARGIN_20),
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.PADDING_8,
                    vertical: Sizes.PADDING_8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.maroon03,
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
          ],
        ),
      ),
    );
  }

  void _onImageHover(bool hovering) {
    setState(() {
      _isHoveringOnImage = hovering;
    });
  }

  double heightOfImage() {
    return widget.imageHeight ?? assignHeight(context, 0.3);
  }

  double widthOfImage() {
    return widget.imageWidth ?? widthOfScreen(context);
  }
}
