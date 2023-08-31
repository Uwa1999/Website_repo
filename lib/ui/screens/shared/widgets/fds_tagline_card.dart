import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/empty.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FdsTagLineCardData {
  IconData? leadingIcon;
  IconData? trailingIcon;
  Color trailingIconColor;
  Color leadingIconColor;
  Color circleBgColor;
  String title;
  Color titleColor;

  FdsTagLineCardData({
    this.leadingIcon,
    this.trailingIcon,
    this.circleBgColor = AppColors.white,
    this.leadingIconColor = AppColors.black,
    this.trailingIconColor = AppColors.white,
    this.titleColor = AppColors.black,
    required this.title,
  });
}

class FdsTagLineCard extends StatefulWidget {
  FdsTagLineCard({
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.width,
    this.height,
    this.offsetY = -40,
    this.elevation = Sizes.ELEVATION_6,
    this.hasAnimation = true,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding = const EdgeInsets.symmetric(
      horizontal: Sizes.PADDING_0,
      vertical: Sizes.PADDING_12,
    ),
  });

  final Widget? leading;
  final Widget? title;

  final Widget? subtitle;
  final Widget? trailing;
  final double? width;
  final double? height;
  final double? elevation;
  final double offsetY;

  final EdgeInsetsGeometry padding;
  final BorderRadius borderRadius;
  final bool hasAnimation;

  @override
  _FdsTagLineCardState createState() => _FdsTagLineCardState();
}

class _FdsTagLineCardState extends State<FdsTagLineCard> {
  bool _hovering = false;
  late AnimationController _controller;
  late Animation<double> animation;

  Future<void> _animateCard() async {
    if (_hovering) {
      try {
        await _controller.forward().orCancel;
      } on TickerCanceled {}
    } else {
      try {
        await _controller.reverse().orCancel;
      } on TickerCanceled {}
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        // widget.hasAnimation
        //   ? MouseRegion(
        //       onEnter: (e) => _mouseEnter(true),
        //       onExit: (e) => _mouseEnter(false),
        //       child: AnimatedBuilder(
        //         animation: _controller,
        //         builder: (context, child) {
        //           return Transform.translate(
        //             offset: Offset(0, animation.value),
        //             child: _buildFdsTagLineCard(),
        //           );
        //         },
        //       ),
        //     )
        //   :
        _buildFdsTagLineCard();
  }

  Widget _buildFdsTagLineCard() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: MediaQuery.of(context).size.height * 0.1,
      child: ClipRRect(
        borderRadius: widget.borderRadius,
        child: Card(
          elevation: widget.elevation,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // widget.leading != null ? Spacer() : EmptyContainer(),
              // widget.leading ?? EmptyContainer(),
              // widget.leading != null ? Spacer() : EmptyContainer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  widget.title ?? EmptyContainer(),
                  widget.title != null ? SizedBoxH5() : EmptyContainer(),
                  widget.subtitle ?? EmptyContainer(),
                  Spacer(),
                ],
              ),
              // widget.trailing != null ? Spacer() : EmptyContainer(),
              // widget.trailing ?? EmptyContainer(),
              // widget.trailing != null ? Spacer() : EmptyContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

class FDSTaglineSection extends StatefulWidget {
  const FDSTaglineSection({Key? key}) : super(key: key);

  @override
  State<FDSTaglineSection> createState() => _FDSTaglineSectionState();
}

class _FDSTaglineSectionState extends State<FDSTaglineSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.maroon06.withOpacity(0.5),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Center(
                child: FDSTaglineInfoSection(
                  title1: StringConst.WE_LISTEN,
                  hasTitle2: false,
                  body: '',
                  title1Style: GoogleFonts.poppins(
                    fontSize: Sizes.TEXT_SIZE_25,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.maroon06.withOpacity(0.5),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Center(
                child: FDSTaglineInfoSection(
                  title1: StringConst.WE_ANTICIPATE,
                  hasTitle2: false,
                  body: '',
                  title1Style: GoogleFonts.poppins(
                    fontSize: Sizes.TEXT_SIZE_25,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: AppColors.maroon06.withOpacity(0.5),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Center(
                child: FDSTaglineInfoSection(
                  title1: StringConst.WE_DELIVER,
                  hasTitle2: false,
                  body: '',
                  title1Style: GoogleFonts.poppins(
                    fontSize: Sizes.TEXT_SIZE_25,
                    fontWeight: FontWeight.w700,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
