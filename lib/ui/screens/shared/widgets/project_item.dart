import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:flutter/material.dart';

class ProductServicesData {
  final String productServicesCoverUrl;
  final String? title;
  final String? category;
  final double width;
  final double height;
  final double mobileWidth;
  final double mobileHeight;
  final VoidCallback? onPressed;

  ProductServicesData({
    this.onPressed,
    required this.productServicesCoverUrl,
    this.title,
    this.category,
    required this.width,
    this.mobileHeight = 0.5,
    this.mobileWidth = 1.0,
    this.height = 0.4,
  });
}

class ProductServicesItem extends StatefulWidget {
  const ProductServicesItem({
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
  _ProductServicesItemState createState() => _ProductServicesItemState();
}

class _ProductServicesItemState extends State<ProductServicesItem> with TickerProviderStateMixin {
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
