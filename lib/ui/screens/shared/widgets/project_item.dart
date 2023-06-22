import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:flutter/material.dart';

class ProjectData {
  final String projectCoverUrl;
  final String? title;
  final String? category;
  final double width;
  final double height;
  final double mobileWidth;
  final double mobileHeight;
  final VoidCallback? onPressed;

  ProjectData({
    this.onPressed,
    required this.projectCoverUrl,
    this.title,
    this.category,
    required this.width,
    this.mobileHeight = 0.5,
    this.mobileWidth = 1.0,
    this.height = 0.4,
  });
}

class ProjectItem extends StatefulWidget {
  const ProjectItem({
    Key? key,
    this.title,
    this.subtitle,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.bannerHeight,
    this.titleStyle,
    this.onTap,
    this.subtitleStyle,
    this.textColor = AppColors.white,
    this.bannerColor,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final String imageUrl;
  final Color? bannerColor;
  final Color textColor;
  final double width;
  final double height;
  final double? bannerHeight;
  final GestureTapCallback? onTap;

  @override
  _ProjectItemState createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> with TickerProviderStateMixin {
  late AnimationController _slideFadeController;
  late AnimationController _indicatorController;
  late Animation<double> _indicatorAnimation;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _indicatorController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideFadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _indicatorAnimation = Tween(
      begin: 100.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _indicatorController,
        curve: Curves.easeIn,
      ),
    );
    _fadeInAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _slideFadeController,
        curve: Curves.easeIn,
      ),
    );
    _slideAnimation = Tween<Offset>(begin: Offset(0, -0.1), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: _slideFadeController,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void dispose() {
    _slideFadeController.dispose();
    _indicatorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          child: Stack(
            children: [
              Image.asset(
                widget.imageUrl,
                width: widget.width,
                height: widget.height,
                fit: BoxFit.fill,
              ),
              // Positioned(
              //   bottom: 0,
              //   child: FadeTransition(
              //     opacity: _fadeInAnimation,
              //     child: SlideTransition(
              //       position: _slideAnimation,
              //       child: ProjectCover(
              //         animation: _indicatorAnimation,
              //         color: widget.bannerColor ?? Colors.black.withOpacity(0.8),
              //         width: widget.width,
              //         height: widget.bannerHeight ?? widget.height / 3,
              //         title: widget.title,
              //         //   subtitle: widget.subtitle,
              //         titleStyle: widget.titleStyle,
              //         subtitleStyle: widget.subtitleStyle,
              //         isHover: _hovering,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void _mouseEnter(bool hovering) {
    setState(() {
      _hovering = hovering;
    });
    if (_hovering) {
      _slideFadeController.forward();
      _indicatorController.forward();
    } else {
      _slideFadeController.reverse();
      _indicatorController.reset();
    }
  }
}
//
// class ProjectCover extends StatelessWidget {
//   const ProjectCover({
//     Key? key,
//     required this.width,
//     required this.height,
//     required this.title,
//     this.subtitle,
//     required this.animation,
//     this.indicatorColor = AppColors.white,
//     this.color,
//     this.subtitleStyle,
//     this.titleStyle,
//     this.isHover = false,
//     this.clickCallback,
//   }) : super(key: key);
//
//   final String title;
//   final String? subtitle;
//   final double width;
//   final double height;
//   final Color? color;
//   final Color indicatorColor;
//   final TextStyle? titleStyle;
//   final TextStyle? subtitleStyle;
//   final VoidCallback? clickCallback;
//
//   final Animation<double> animation;
//
//   final bool isHover;
//
//   @override
//   Widget build(BuildContext context) {
//     TextTheme textTheme = Theme.of(context).textTheme;
//     return GestureDetector(
//       onTap: clickCallback,
//       child: Container(
//         width: width,
//         height: height,
//         color: color ?? Colors.black.withOpacity(0.8),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             AnimatedHoverIndicator2(
//               animation: animation,
//               indicatorColor: indicatorColor,
//             ),
//             SizedBoxW16(),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: titleStyle ??
//                       textTheme.headlineMedium?.copyWith(
//                         color: AppColors.white,
//                       ),
//                 ),
//                 SizedBoxH8(),
//                 // Text(
//                 //   subtitle,
//                 //   style: subtitleStyle ??
//                 //       textTheme.titleMedium?.copyWith(
//                 //         color: AppColors.white,
//                 //         fontSize: Sizes.TEXT_SIZE_16,
//                 //       ),
//                 // ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
