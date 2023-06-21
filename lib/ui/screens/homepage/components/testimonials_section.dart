import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:flutter/material.dart';

class TestimonialsSection extends StatelessWidget {
  TestimonialsSection({Key? key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = widthOfScreen(context);
    double screenHeight = heightOfScreen(context);
    double contentAreaWidth = screenWidth * 0.8;
    double contentAreaHeight = screenHeight * 1.0;

    return ContentArea(
      width: contentAreaWidth,
      height: contentAreaHeight,
      child: Row(
        children: [
          Stack(
            children: [
              Card(
                child: NimbusInfoSection1(
                  title1: StringConst.TESTIMONIALS_SECTION_TITLE,
                  hasTitle2: false,
                  body: StringConst.TESTIMONIALS_1,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
