import 'package:flutter/material.dart';
import 'package:layout/layout.dart';

enum DisplayType {
  desktop,
  mobile,
}

const _desktopPortraitBreakpoint = 700.0;
const _desktopLandscapeBreakpoint = 1000.0;
const _ipadProBreakpoint = 1000.0;

/// Returns the [DisplayType] for the current screen. This app only supports
/// mobile and desktop layouts, and as such we only have one breakpoint.
DisplayType displayTypeOf(BuildContext context) {
  final orientation = MediaQuery.of(context).orientation;
  final width = MediaQuery.of(context).size.width;

  if ((orientation == Orientation.landscape && width > _desktopLandscapeBreakpoint) || (orientation == Orientation.portrait && width > _desktopPortraitBreakpoint)) {
    return DisplayType.desktop;
  } else {
    return DisplayType.mobile;
  }
}

/// Returns a boolean if we are in a display of [DisplayType.desktop]. Used to
/// build adaptive and responsive layouts.
bool isDisplayDesktop(BuildContext context) {
  return displayTypeOf(context) == DisplayType.desktop;
}

/// Returns a boolean if we are in a display of [DisplayType.desktop] but less
/// than [_desktopLandscapeBreakpoint] width. Used to build adaptive and responsive layouts.
bool isDisplaySmallDesktop(BuildContext context) {
  return isDisplayDesktop(context) && MediaQuery.of(context).size.width < _desktopLandscapeBreakpoint;
}

bool isDisplaySmallDesktopOrIpadPro(BuildContext context) {
  return isDisplaySmallDesktop(context) || (MediaQuery.of(context).size.width > _ipadProBreakpoint && MediaQuery.of(context).size.width < 1170);
}

double widthOfScreen(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double heightOfScreen(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double assignHeight(
  BuildContext context,
  double fraction, {
  double additions = 0.0,
  double subs = 0.0,
}) {
  return (heightOfScreen(context) - (subs) + (additions)) * fraction;
}

double assignWidth(
  BuildContext context,
  double fraction, {
  double additions = 0,
  double subs = 0,
}) {
  return (widthOfScreen(context) - (subs) + (additions)) * fraction;
}

double responsiveSize(
  BuildContext context,
  double xs,
  double lg, {
  double? sm,
  double? md,
  double? xl,
}) {
  return context.layout.value(
    xs: xs,
    sm: sm ?? (md ?? xs), //assign md to sm if it is not null, if null assign xs
    md: md ?? lg,
    lg: lg,
    xl: xl ?? lg,
  );
}

int responsiveSizeInt(
  BuildContext context,
  int xs,
  int lg, {
  int? sm,
  int? md,
  int? xl,
}) {
  return context.layout.value(
    xs: xs,
    sm: sm ?? (md ?? xs), //assign md to sm if it is not null, if null assign xs
    md: md ?? lg,
    lg: lg,
    xl: xl ?? lg,
  );
}

Color responsiveColor(
  BuildContext context,
  Color xs,
  Color lg, {
  Color? sm,
  Color? md,
  Color? xl,
}) {
  return context.layout.value(
    xs: xs,
    sm: sm ?? (md ?? xs), //assign md to sm if it is not null, if null assign xs
    md: md ?? lg,
    lg: lg,
    xl: xl ?? lg,
  );
}

double getSidePadding(BuildContext context) {
  double sidePadding = assignWidth(context, 0.05);
  return responsiveSize(context, 30, sidePadding, md: sidePadding);
}

bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 650;
bool isTab(BuildContext context) => MediaQuery.of(context).size.width < 1300 && MediaQuery.of(context).size.width >= 650;
bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1300;

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    Key? key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  }) : super(key: key);

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) => MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    // If our width is more than 1100 then we consider it a desktop
    if (_size.width >= 1100) {
      return desktop;
    }
    // If width it less then 1100 and more then 850 we consider it as tablet
    else if (_size.width >= 850 && tablet != null) {
      return tablet!;
    }
    // Or less then that we called it mobile
    else {
      return mobile;
    }
  }
}
