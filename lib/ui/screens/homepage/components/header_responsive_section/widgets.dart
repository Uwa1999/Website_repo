import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/buttons/social_button.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/circular_container.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_card.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_link.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderImage extends StatefulWidget {
  const HeaderImage({
    Key? key,
    required this.controller,
    this.globeSize = 150,
    this.imageHeight,
    this.imageWidth,
    this.fit,
  }) : super(key: key);

  final double? globeSize;
  final double? imageWidth;
  final double? imageHeight;
  final BoxFit? fit;
  final AnimationController controller;

  @override
  _HeaderImageState createState() => _HeaderImageState();
}

class _HeaderImageState extends State<HeaderImage> {
  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Positioned(
        //   left: 0,
        //   // child: RotationTransition(
        //   //   turns: widget.controller,
        //   //   child: Image.asset(
        //   //   //  ImagePath.DOTS_GLOBE_GREY,
        //   //    // height: widget.globeSize,
        //   // //    width: widget.globeSize,
        //   //   ),
        //   // ),
        // ),
        // Image.asset(
        //   ImagePath.DEV_HEADER,
        //   width: widget.imageWidth,
        //   height: widget.imageHeight,
        //   fit: widget.fit,
        // ),
      ],
    );
  }
}

List<Widget> buildSocialIcons(List<SocialButtonData> socialItems) {
  List<Widget> items = [];
  for (int index = 0; index < socialItems.length; index++) {
    items.add(
      // InkWell(
      //   onTap: () => openUrlLink(socialItems[index].url),
      //   child: Icon(
      //     socialItems[index].iconData,
      //     color: AppColors.black,
      //     size: Sizes.ICON_SIZE_18,
      //   ),
      // ),
      NimBusLink(
        url: socialItems[index].url,
        child: Icon(
          socialItems[index].iconData,
          color: AppColors.black,
          size: Sizes.ICON_SIZE_18,
        ),
      ),
    );
    items.add(SizedBoxW20());
  }
  return items;
}

List<Widget> buildCardRow({
  required BuildContext context,
  required List<FdsTagLineCardData> data,
  required double width,
  bool isHorizontal = true,
  bool isWrap = false,
  bool hasAnimation = true,
}) {
  List<Widget> items = [];

  double cardWidth = responsiveSize(
    context,
    Sizes.WIDTH_32,
    Sizes.WIDTH_40,
    md: Sizes.WIDTH_36,
  );
  double iconSize = responsiveSize(
    context,
    Sizes.ICON_SIZE_14,
    Sizes.ICON_SIZE_20,
  );
  double trailingIconSize = responsiveSize(
    context,
    Sizes.ICON_SIZE_28,
    Sizes.ICON_SIZE_30,
    md: Sizes.ICON_SIZE_30,
  );
  for (int index = 0; index < data.length; index++) {
    items.add(
      FdsTagLineCard(
        width: width,
        height: responsiveSize(
          context,
          110,
          110,
        ),
        hasAnimation: hasAnimation,
        leading: CircularContainer(
          width: cardWidth,
          height: cardWidth,
          iconSize: iconSize,
          backgroundColor: data[index].circleBgColor,
          iconColor: data[index].leadingIconColor,
        ),
        title: Center(
          child: SelectableText(
            data[index].title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: responsiveSize(
                context,
                Sizes.TEXT_SIZE_20,
                Sizes.TEXT_SIZE_30,
              ),
              color: AppColors.black,
            ),
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          size: trailingIconSize,
          color: data[index].trailingIconColor,
        ),
      ),
    );
    //run this only on mobile devices and laptops but not on tablets.
    // We use `Wrap` to make the widgets wrap on the tablet view
    if (!isWrap) {
      if (isHorizontal) {
        items.add(SizedBoxW36());
      } else {
        items.add(SizedBoxH30());
      }
    }
  }

  return items;
}

double computeHeight(double offset, double sizeOfGlobe, double sizeOfBlob) {
  double sum = (offset + sizeOfGlobe) - sizeOfBlob;
  if (sum < 0) {
    return sizeOfBlob;
  } else {
    return sum + sizeOfBlob;
  }
}
