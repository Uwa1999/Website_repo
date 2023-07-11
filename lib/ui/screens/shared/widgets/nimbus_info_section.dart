import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/empty.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';

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
  // final double dividerHeight;
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
    // this.dividerHeight = Sizes.HEIGHT_40,
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
                    style: title1Style ?? titleStyle?.copyWith(color: AppColors.black),
                  ),
                  // hasTitle2
                  //      ? SizedBox(
                  //          height: responsiveSize(
                  //            context,
                  //            Sizes.HEIGHT_4,
                  //            Sizes.HEIGHT_16,
                  //            md: Sizes.HEIGHT_8,
                  //          ),
                  //        )
                  //      : EmptyContainer(),
                  //  hasTitle2
                  //      ? Text(
                  //  title2!,
                  //     style: title2Style ?? titleStyle,
                  //   )
                  // : EmptyContainer(),
                  SizedBoxH10(),
                  Text(
                    body,
                    style: textTheme.bodySmall?.copyWith(fontSize: fontSize, height: 1.8, color: AppColors.black),
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title1,
                  style: title1Style ?? titleStyle,
                ),
                // AnimatedIcon(
                //   icon: AnimatedIcons.menu_arrow,
                //   progress: animation,
                //   size: 72.0,
                //   semanticLabel: 'Show menu',
                // ),
              ],
            ),
            // hasTitle2
            //     ? SizedBox(
            //         height: responsiveSize(
            //           context,
            //           Sizes.HEIGHT_4,
            //           Sizes.HEIGHT_16,
            //           md: Sizes.HEIGHT_8,
            //         ),
            //       )
            //     : EmptyContainer(),
            // hasTitle2
            //     ? Text(
            //         title2,
            //         style: title2Style ?? titleStyle,
            //       )
            //     : EmptyContainer(),
            // SizedBoxH10(),
            // Text(
            //   body,
            //   style: textTheme.bodyMedium?.copyWith(fontSize: fontSize, height: 1.8),
            // ),
            // child != null ? SizedBoxH30() : EmptyContainer(),
            // child ?? EmptyContainer(),
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
  // final double dividerHeight;
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
    // this.dividerHeight = Sizes.HEIGHT_40,
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
                    style: title1Style ?? titleStyle,
                  ),
                  // hasTitle2
                  //      ? SizedBox(
                  //          height: responsiveSize(
                  //            context,
                  //            Sizes.HEIGHT_4,
                  //            Sizes.HEIGHT_16,
                  //            md: Sizes.HEIGHT_8,
                  //          ),
                  //        )
                  //      : EmptyContainer(),
                  //  hasTitle2
                  //      ? Text(
                  //  title2!,
                  //     style: title2Style ?? titleStyle,
                  //   )
                  // : EmptyContainer(),
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
  // final double dividerHeight;
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
    // this.dividerHeight = Sizes.HEIGHT_40,
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
                  // Text(
                  //   title1!,
                  //   style: title1Style ?? titleStyle,
                  // ),
                  // hasTitle2
                  //      ? SizedBox(
                  //          height: responsiveSize(
                  //            context,
                  //            Sizes.HEIGHT_4,
                  //            Sizes.HEIGHT_16,
                  //            md: Sizes.HEIGHT_8,
                  //          ),
                  //        )
                  //      : EmptyContainer(),
                  //  hasTitle2
                  //      ? Text(
                  //  title2!,
                  //     style: title2Style ?? titleStyle,
                  //   )
                  // : EmptyContainer(),
                  SizedBoxH20(),
                  Text(
                    body,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: fontSize,
                      height: 1.8,
                      color: AppColors.black,
                    ),
                  ),
                  // child != null ? SizedBoxH30() : EmptyContainer(),
                  // child ?? EmptyContainer(),
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
  // final double dividerHeight;
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
    // this.dividerHeight = Sizes.HEIGHT_40,
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
                //   mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title1!,
                    style: title1Style ?? titleStyle,
                  ),
                  // hasTitle2
                  //      ? SizedBox(
                  //          height: responsiveSize(
                  //            context,
                  //            Sizes.HEIGHT_4,
                  //            Sizes.HEIGHT_16,
                  //            md: Sizes.HEIGHT_8,
                  //          ),
                  //        )
                  //      : EmptyContainer(),
                  //  hasTitle2
                  //      ? Text(
                  //  title2!,
                  //     style: title2Style ?? titleStyle,
                  //   )
                  // : EmptyContainer(),
                  SizedBoxH20(),
                  Text(
                    body,
                    style: textTheme.bodySmall?.copyWith(
                      fontSize: fontSize,
                      height: 1.8,
                      color: AppColors.black,
                    ),
                  ),
                  // child != null ? SizedBoxH30() : EmptyContainer(),
                  // child ?? EmptyContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
