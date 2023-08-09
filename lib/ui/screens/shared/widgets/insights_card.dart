import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

//Desktop Screen
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
  bool _isHovered = false;
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
    final hoveredTransform = Matrix4.identity()..translate(0, -8, 0);
    final transform = _isHovered ? hoveredTransform : Matrix4.identity();

    return MouseRegion(
      onEnter: (e) => _onEntered(true),
      onExit: (e) => _onEntered(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  HoverContainer(
                    transform: Matrix4.identity()..translate(0, -8, 0),
                    hoverMargin: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)),
                    hoverDecoration: BoxDecoration(color: AppColors.grey350, borderRadius: BorderRadius.circular(16)),
                    child: Card(
                      // shadowColor: AppColors.black,
                      //   margin: const EdgeInsets.only(left: Sizes.MARGIN_18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(Sizes.RADIUS_16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            MouseRegion(
                              onEnter: (e) => _onImageHover(true),
                              onExit: (e) => _onImageHover(false),
                              cursor: SystemMouseCursors.click,
                              child: AnimatedOpacity(
                                opacity: _isHoveringOnImage ? 1.0 : 0.80,
                                duration: Duration(milliseconds: 300),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(Sizes.RADIUS_16),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        widget.imageUrl,
                                        height: MediaQuery.of(context).size.height * 0.3,
                                        // width: MediaQuery.of(context).size.width * 0.7,
                                        fit: BoxFit.contain,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            widget.title,
                                            style: widget.dateStyle ??
                                                textTheme.titleMedium?.copyWith(
                                                  fontSize: Sizes.TEXT_SIZE_18,
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors.black,
                                                ),
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
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Image.asset(
                            //   widget.imageUrl,
                            //   height: MediaQuery.of(context).size.height * 0.3,
                            //   // width: MediaQuery.of(context).size.width * 0.7,
                            //   fit: BoxFit.fitHeight,
                            // ),
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
                            SizedBoxH10(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Insights Label
                  Container(
                    margin: const EdgeInsets.only(top: Sizes.MARGIN_210),
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
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onImageHover(bool hovering) {
    setState(() {
      _isHoveringOnImage = hovering;
    });
  }

  void _onEntered(bool hovering) {
    setState(() {
      this._isHovered = _isHovered;
    });
  }

  double heightOfImage() {
    return widget.imageHeight ?? assignHeight(context, 0.3);
  }

  double widthOfImage() {
    return widget.imageWidth ?? widthOfScreen(context);
  }
}

//Mobile Screen
class SmallInsightsData {
  final String category;
  final String date;
  final String title;
  final String subtitle;
  final String? buttonText;
  final String imageUrl;
  final VoidCallback? onPressed;

  SmallInsightsData({
    this.onPressed,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.date,
    this.buttonText,
    required this.imageUrl,
  });
}

class SmallInsightsCard extends StatefulWidget {
  SmallInsightsCard({
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
  State<SmallInsightsCard> createState() => _SmallInsightsCardState();
}

class _SmallInsightsCardState extends State<SmallInsightsCard> {
  bool _isHoveringOnImage = false;
  bool _isHovered = false;
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
    final hoveredTransform = Matrix4.identity()..translate(0, -8, 0);
    final transform = _isHovered ? hoveredTransform : Matrix4.identity();

    return MouseRegion(
      onEnter: (e) => _onEntered(true),
      onExit: (e) => _onEntered(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  HoverContainer(
                    transform: Matrix4.identity()..translate(0, -8, 0),
                    hoverMargin: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16)),
                    hoverDecoration: BoxDecoration(color: AppColors.grey350, borderRadius: BorderRadius.circular(16)),
                    child: Card(
                      // shadowColor: AppColors.black,
                      //   margin: const EdgeInsets.only(left: Sizes.MARGIN_18),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(
                          Radius.circular(Sizes.RADIUS_16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            MouseRegion(
                              onEnter: (e) => _onImageHover(true),
                              onExit: (e) => _onImageHover(false),
                              cursor: SystemMouseCursors.click,
                              child: AnimatedOpacity(
                                opacity: _isHoveringOnImage ? 1.0 : 0.85,
                                duration: Duration(milliseconds: 300),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(Sizes.RADIUS_16),
                                  ),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        widget.imageUrl,
                                        height: MediaQuery.of(context).size.height * 0.3,
                                        // width: MediaQuery.of(context).size.width * 0.7,
                                        fit: BoxFit.contain,
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                                      //   child: Align(
                                      //     alignment: Alignment.centerLeft,
                                      //     child: Text(
                                      //       widget.title,
                                      //       style: widget.dateStyle ??
                                      //           textTheme.titleSmall?.copyWith(
                                      //             fontSize: Sizes.TEXT_SIZE_15,
                                      //             fontWeight: FontWeight.bold,
                                      //             color: AppColors.black,
                                      //           ),
                                      //     ),
                                      //   ),
                                      // ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                      //   child: Align(
                                      //     alignment: Alignment.centerLeft,
                                      //     child: Text(
                                      //       widget.subtitle,
                                      //       style: widget.titleStyle ?? textTheme.bodySmall,
                                      //
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Image.asset(
                            //   widget.imageUrl,
                            //   height: MediaQuery.of(context).size.height * 0.3,
                            //   // width: MediaQuery.of(context).size.width * 0.7,
                            //   fit: BoxFit.fitHeight,
                            // ),
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
                            SizedBoxH10(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  //Insights Label
                  Container(
                    margin: const EdgeInsets.only(top: Sizes.MARGIN_210),
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
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onImageHover(bool hovering) {
    setState(() {
      _isHoveringOnImage = hovering;
    });
  }

  void _onEntered(bool hovering) {
    setState(() {
      this._isHovered = _isHovered;
    });
  }

  double heightOfImage() {
    return widget.imageHeight ?? assignHeight(context, 0.3);
  }

  double widthOfImage() {
    return widget.imageWidth ?? widthOfScreen(context);
  }
}
