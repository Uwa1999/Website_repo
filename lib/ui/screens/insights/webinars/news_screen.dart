import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';

class NewsDescScreen extends StatefulWidget {
  const NewsDescScreen({Key? key}) : super(key: key);

  @override
  State<NewsDescScreen> createState() => _NewsDescScreenState();
}

class _NewsDescScreenState extends State<NewsDescScreen> {
  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) == (!isTab(context)) ? DesktopNewsDescScreen() : MobileNewsDescSection();
  }
}

//Desktop Screen
class DesktopNewsDescScreen extends StatefulWidget {
  const DesktopNewsDescScreen({Key? key}) : super(key: key);

  @override
  State<DesktopNewsDescScreen> createState() => _DesktopNewsDescScreenState();
}

class _DesktopNewsDescScreenState extends State<DesktopNewsDescScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBoxH10(),
          Padding(
            padding: EdgeInsets.only(
              left: Sizes.PADDING_100,
              right: Sizes.PADDING_100,
            ),
            child: NimbusInfoInsightSection(
              title1: '',
              hasTitle2: false,
              body: StringConst.NEWS_DESC1,
            ),
          ),
          SizedBoxH50(),
        ],
      ),
    );
  }
}

//Mobile Screen
class MobileNewsDescSection extends StatefulWidget {
  const MobileNewsDescSection({Key? key}) : super(key: key);

  @override
  State<MobileNewsDescSection> createState() => _MobileNewsDescSectionState();
}

class _MobileNewsDescSectionState extends State<MobileNewsDescSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBoxH10(),
          Padding(
            padding: const EdgeInsets.only(
              left: Sizes.PADDING_30,
              right: Sizes.PADDING_30,
            ),
            child: NimbusInfoInsightSection(
              title1: '',
              hasTitle2: false,
              body: StringConst.NEWS_DESC1,
            ),
          ),
          SizedBoxH50(),
        ],
      ),
    );
  }
}
