import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';

class OurLocationSection extends StatefulWidget {
  const OurLocationSection({Key? key}) : super(key: key);

  @override
  State<OurLocationSection> createState() => _OurLocationSectionState();
}

class _OurLocationSectionState extends State<OurLocationSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ContentArea(
          child: NimbusInfoSection2(
            title1: StringConst.OUR_LOCATION,
            hasTitle2: false,
          ),
        ),
        SizedBoxH20(),
        Padding(
          padding: EdgeInsets.only(
            left: Sizes.PADDING_80,
            right: Sizes.PADDING_80,
          ),
          child: ContentArea(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
            backgroundColor: AppColors.maroon03,
            borderRadius: const BorderRadius.all(
              Radius.circular(Sizes.RADIUS_8),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(Sizes.RADIUS_8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.asset(
                  ImagePath.BOX_COVER_MAP,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        SizedBoxH50(),
      ],
    );
  }
}
