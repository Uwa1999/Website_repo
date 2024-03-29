import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/empty.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class NimbusInfoSection1 extends StatelessWidget {
  final String? title1;
  final String? title2;
  final bool hasTitle2;
  final String body;
  final TextStyle? sectionTitleStyle;
  final TextStyle? title1Style;
  final TextStyle? title2Style;
  final TextStyle? bodyStyle;
  final Color dividerColor;
  final double? thickness;
  final int quarterTurns;
  final Widget? child;

  NimbusInfoSection1({
    this.title1 = "",
    required this.body,
    this.title2 = "",
    this.sectionTitleStyle,
    this.title1Style,
    this.hasTitle2 = true,
    this.title2Style,
    this.bodyStyle,
    this.thickness = 1.15,
    this.quarterTurns = 3,
    this.dividerColor = AppColors.black,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? titleStyle = textTheme.headlineMedium?.copyWith(
      fontSize: responsiveSize(context, 26, 36, md: 32),
      color: AppColors.black,
    );
    double fontSize = responsiveSize(context, 16, 18);
    return Container(
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title1!,
                    style: title1Style ??
                        titleStyle?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  SizedBoxH10(),
                  Text(
                    body,
                    textAlign: TextAlign.justify,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: fontSize,
                      height: 1.8,
                      color: AppColors.black,
                    ),
                  ),
                  child != null ? SizedBoxH30() : EmptyContainer(),
                  child ?? EmptyContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NimbusInfoSection2 extends StatelessWidget {
  final String title1;
  final String title2;
  final bool hasTitle2;
  final String body;
  final TextStyle? sectionTitleStyle;
  final TextStyle? title1Style;
  final TextStyle? title2Style;
  final TextStyle? bodyStyle;
  final Color dividerColor;
  final double? thickness;
  final double dividerWidth;
  final Widget? child;

  NimbusInfoSection2({
    this.title1 = "",
    this.body = "",
    this.title2 = "",
    this.sectionTitleStyle,
    this.title1Style,
    this.hasTitle2 = true,
    this.title2Style,
    this.bodyStyle,
    this.thickness = 1.15,
    this.dividerColor = AppColors.black,
    this.dividerWidth = Sizes.HEIGHT_64,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? titleStyle = textTheme.headlineMedium?.copyWith(
      fontSize: responsiveSize(context, 26, 48, md: 32),
      color: AppColors.black,
    );
    double fontSize = responsiveSize(context, 16, 18);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title1,
                  style: title1Style ??
                      titleStyle?.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ],
            ),
            SizedBoxH10(),
            Text(
              body,
              textAlign: TextAlign.justify,
              style: textTheme.bodySmall?.copyWith(
                fontSize: fontSize,
                height: 1.3,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class NimbusInfoSection3 extends StatelessWidget {
  final String? title1;
  final String? title2;
  final bool hasTitle2;
  final String body;
  final TextStyle? sectionTitleStyle;
  final TextStyle? title1Style;
  final TextStyle? title2Style;
  final TextStyle? bodyStyle;
  final Color dividerColor;
  final double? thickness;
  final int quarterTurns;
  final Widget? child;

  NimbusInfoSection3({
    this.title1 = "",
    required this.body,
    this.title2 = "",
    this.sectionTitleStyle,
    this.title1Style,
    this.hasTitle2 = true,
    this.title2Style,
    this.bodyStyle,
    this.thickness = 1.15,
    this.quarterTurns = 3,
    this.dividerColor = AppColors.white,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? titleStyle = textTheme.headlineMedium?.copyWith(
      fontSize: responsiveSize(context, 26, 36, md: 32),
      color: AppColors.white,
    );
    double fontSize = responsiveSize(context, 16, 18);
    return Container(
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title1!,
                    style: title1Style ??
                        titleStyle?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  SizedBoxH20(),
                  Text(
                    body,
                    textAlign: TextAlign.justify,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: fontSize,
                      height: 1.8,
                      color: AppColors.white,
                    ),
                  ),
                  child != null ? SizedBoxH30() : EmptyContainer(),
                  child ?? EmptyContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NimbusInfoSection4 extends StatelessWidget {
  final String? title1;
  final String? title2;
  final bool hasTitle2;
  final String body;
  final TextStyle? sectionTitleStyle;
  final TextStyle? title1Style;
  final TextStyle? title2Style;
  final TextStyle? bodyStyle;
  final Color dividerColor;
  final double? thickness;
  final int quarterTurns;
  final Widget? child;

  NimbusInfoSection4({
    this.title1 = "",
    required this.body,
    this.title2 = "",
    this.sectionTitleStyle,
    this.title1Style,
    this.hasTitle2 = true,
    this.title2Style,
    this.bodyStyle,
    this.thickness = 1.15,
    this.quarterTurns = 3,
    this.dividerColor = AppColors.black,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double fontSize = responsiveSize(context, 16, 18);
    return Container(
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    body,
                    textAlign: TextAlign.justify,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: fontSize,
                      height: 1.8,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NimbusInfoSection5 extends StatelessWidget {
  final String? title1;
  final String? title2;
  final bool hasTitle2;
  final String body;
  final TextStyle? sectionTitleStyle;
  final TextStyle? title1Style;
  final TextStyle? title2Style;
  final TextStyle? bodyStyle;
  final Color dividerColor;
  final double? thickness;
  final int quarterTurns;
  final Widget? child;

  NimbusInfoSection5({
    this.title1 = "",
    required this.body,
    this.title2 = "",
    this.sectionTitleStyle,
    this.title1Style,
    this.hasTitle2 = true,
    this.title2Style,
    this.bodyStyle,
    this.thickness = 1.15,
    this.quarterTurns = 3,
    this.dividerColor = AppColors.black,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? titleStyle = textTheme.headlineMedium?.copyWith(
      fontSize: responsiveSize(context, 26, 26, md: 32),
      color: AppColors.black,
    );
    double fontSize = responsiveSize(context, 16, 18);
    return Container(
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title1!,
                    style: title1Style ??
                        titleStyle?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                  ),
                  SizedBoxH20(),
                  Text(
                    body,
                    textAlign: TextAlign.justify,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: fontSize,
                      height: 1.8,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NimbusInfoAboutSection extends StatelessWidget {
  final String? title1;
  final String? title2;
  final bool hasTitle2;
  final String body;
  final String body2;
  final String body3;
  final TextStyle? sectionTitleStyle;
  final TextStyle? title1Style;
  final TextStyle? title2Style;
  final TextStyle? bodyStyle;
  final Color dividerColor;
  final double? thickness;
  final int quarterTurns;
  final Widget? child;
  final String url;
  final LinkTarget linkTarget;
  final bool opensUrl;

  NimbusInfoAboutSection({
    this.title1 = "",
    required this.body,
    required this.body2,
    required this.body3,
    this.title2 = "",
    this.sectionTitleStyle,
    this.title1Style,
    this.hasTitle2 = true,
    this.title2Style,
    this.bodyStyle,
    this.thickness = 1.15,
    this.quarterTurns = 3,
    this.dividerColor = AppColors.black,
    this.child,
    this.opensUrl = false,
    this.url = "",
    this.linkTarget = LinkTarget.blank,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? titleStyle = textTheme.headlineMedium?.copyWith(
      fontSize: responsiveSize(context, 40, 36, md: 32),
      color: AppColors.black,
    );
    double fontSize = responsiveSize(context, 15, 18);
    return Container(
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title1!,
                    style: title1Style ?? titleStyle,
                  ),
                  SizedBoxH10(),
                  RichText(
                    textAlign: TextAlign.justify,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: body,
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: fontSize,
                            height: 1.8,
                            color: AppColors.black,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                        TextSpan(
                          text: body2,
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: fontSize,
                            height: 1.8,
                            color: AppColors.blue300,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('-----FDSI WEBPAGE-----');
                              launch(StringConst.FDSI_URL);
                            },
                        ),
                        TextSpan(
                          text: body3,
                          style: textTheme.bodySmall?.copyWith(
                            fontSize: fontSize,
                            height: 1.8,
                            color: AppColors.black,
                            fontWeight: FontWeight.w100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  child != null ? SizedBoxH30() : EmptyContainer(),
                  child ?? EmptyContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NimbusInfoTeamSection extends StatelessWidget {
  final String? title1;
  final String? title2;
  final bool hasTitle2;
  final String body;
  final TextStyle? sectionTitleStyle;
  final TextStyle? title1Style;
  final TextStyle? title2Style;
  final TextStyle? bodyStyle;
  final Color dividerColor;
  final double? thickness;
  final int quarterTurns;
  final Widget? child;

  NimbusInfoTeamSection({
    this.title1 = "",
    required this.body,
    this.title2 = "",
    this.sectionTitleStyle,
    this.title1Style,
    this.hasTitle2 = true,
    this.title2Style,
    this.bodyStyle,
    this.thickness = 1.15,
    this.quarterTurns = 3,
    this.dividerColor = AppColors.black,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? titleStyle = textTheme.headlineMedium?.copyWith(
      fontSize: responsiveSize(context, 18, 36, md: 32),
      color: AppColors.black,
    );
    double fontSize = responsiveSize(context, 15, 18);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    title1!,
                    style: title1Style ??
                        titleStyle?.copyWith(
                          color: AppColors.maroon04,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                ),
                Center(
                  child: Text(
                    body,
                    textAlign: TextAlign.justify,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: fontSize,
                      color: AppColors.maroon04,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NimbusInfoMissionSection extends StatelessWidget {
  final String title1;
  final String title2;
  final bool hasTitle2;
  final String body;
  final TextStyle? sectionTitleStyle;
  final TextStyle? title1Style;
  final TextStyle? title2Style;
  final TextStyle? bodyStyle;
  final Color dividerColor;
  final double? thickness;
  final double dividerWidth;
  final Widget? child;

  NimbusInfoMissionSection({
    this.title1 = "",
    this.body = "",
    this.title2 = "",
    this.sectionTitleStyle,
    this.title1Style,
    this.hasTitle2 = true,
    this.title2Style,
    this.bodyStyle,
    this.thickness = 1.15,
    this.dividerColor = AppColors.black,
    this.dividerWidth = Sizes.HEIGHT_64,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? titleStyle = textTheme.headlineMedium?.copyWith(
      fontSize: responsiveSize(context, 26, 48, md: 32),
      color: AppColors.black,
    );
    double fontSize = responsiveSize(context, 16, 18);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title1,
                  style: title1Style ??
                      titleStyle?.copyWith(
                        color: AppColors.black,
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ],
            ),
            SizedBoxH10(),
            Text(
              body,
              textAlign: TextAlign.justify,
              style: textTheme.bodySmall?.copyWith(
                fontSize: fontSize,
                height: 1.3,
                color: AppColors.black,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class NimbusInfoInsightSection extends StatelessWidget {
  final String? title1;
  final String? title2;
  final bool hasTitle2;
  final String body;
  final TextStyle? sectionTitleStyle;
  final TextStyle? title1Style;
  final TextStyle? title2Style;
  final TextStyle? bodyStyle;
  final Color dividerColor;
  final double? thickness;
  final int quarterTurns;
  final Widget? child;

  NimbusInfoInsightSection({
    this.title1 = "",
    required this.body,
    this.title2 = "",
    this.sectionTitleStyle,
    this.title1Style,
    this.hasTitle2 = true,
    this.title2Style,
    this.bodyStyle,
    this.thickness = 1.15,
    this.quarterTurns = 3,
    this.dividerColor = AppColors.black,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? titleStyle = textTheme.headlineMedium?.copyWith(
      fontSize: responsiveSize(context, 26, 26, md: 32),
      color: AppColors.black,
    );
    double fontSize = responsiveSize(context, 16, 18);
    return Container(
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title1!,
                    style: title1Style ??
                        titleStyle?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                        ),
                  ),
                  SizedBoxH20(),
                  Text(
                    body,
                    textAlign: TextAlign.justify,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: fontSize,
                      height: 1.8,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NimbusInfoInsightTitle extends StatelessWidget {
  final String? title1;
  final String? title2;
  final bool hasTitle2;
  final String body;
  final TextStyle? sectionTitleStyle;
  final TextStyle? title1Style;
  final TextStyle? title2Style;
  final TextStyle? bodyStyle;
  final Color dividerColor;
  final double? thickness;
  final int quarterTurns;
  final Widget? child;

  NimbusInfoInsightTitle({
    this.title1 = "",
    required this.body,
    this.title2 = "",
    this.sectionTitleStyle,
    this.title1Style,
    this.hasTitle2 = true,
    this.title2Style,
    this.bodyStyle,
    this.thickness = 1.15,
    this.quarterTurns = 3,
    this.dividerColor = AppColors.white,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? titleStyle = textTheme.headlineMedium?.copyWith(
      fontSize: responsiveSize(context, 26, 36, md: 32),
      color: AppColors.white,
    );
    double fontSize = responsiveSize(context, 16, 18);
    return Container(
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title1!,
                    style: title1Style ??
                        titleStyle?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  SizedBoxH20(),
                  Text(
                    body,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: fontSize,
                      height: 1.8,
                      color: AppColors.white,
                    ),
                  ),
                  child != null ? SizedBoxH30() : EmptyContainer(),
                  child ?? EmptyContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FDSTaglineInfoSection extends StatelessWidget {
  final String? title1;
  final String? title2;
  final bool hasTitle2;
  final String body;
  final TextStyle? sectionTitleStyle;
  final TextStyle? title1Style;
  final TextStyle? title2Style;
  final TextStyle? bodyStyle;
  final Color dividerColor;
  final double? thickness;
  final int quarterTurns;
  final Widget? child;

  FDSTaglineInfoSection({
    this.title1 = "",
    required this.body,
    this.title2 = "",
    this.sectionTitleStyle,
    this.title1Style,
    this.hasTitle2 = true,
    this.title2Style,
    this.bodyStyle,
    this.thickness = 1.15,
    this.quarterTurns = 3,
    this.dividerColor = AppColors.black,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    TextStyle? titleStyle = textTheme.headlineMedium?.copyWith(
      fontSize: responsiveSize(context, 26, 36, md: 32),
      color: AppColors.black,
    );
    return Container(
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  child ?? EmptyContainer(),
                  Text(
                    title1!,
                    style: title1Style ??
                        titleStyle?.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w900,
                        ),
                  ),
                  child ?? EmptyContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
