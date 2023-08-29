import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsDescScreen extends StatefulWidget {
  const EventsDescScreen({Key? key}) : super(key: key);

  @override
  State<EventsDescScreen> createState() => _EventsDescScreenState();
}

class _EventsDescScreenState extends State<EventsDescScreen> {
  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) == (!isTab(context)) ? DesktopEventsDescScreen() : MobileEventsDescSection();
  }
}

//Desktop Screen
class DesktopEventsDescScreen extends StatefulWidget {
  const DesktopEventsDescScreen({Key? key}) : super(key: key);

  @override
  State<DesktopEventsDescScreen> createState() => _DesktopEventsDescScreenState();
}

class _DesktopEventsDescScreenState extends State<DesktopEventsDescScreen> {
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
              body: StringConst.EVENTS_DESC1,
            ),
          ),
          SizedBoxH30(),
          Padding(
            padding: EdgeInsets.only(
              left: Sizes.PADDING_100,
              right: Sizes.PADDING_100,
            ),
            child: NimbusInfoInsightSection(
              title1: StringConst.EVENTS_DESC_SUBTITLE2,
              hasTitle2: false,
              body: StringConst.EVENTS_DESC2,
              title1Style: GoogleFonts.poppins(
                fontSize: Sizes.TEXT_SIZE_28,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBoxH30(),
          Padding(
            padding: EdgeInsets.only(
              left: Sizes.PADDING_100,
              right: Sizes.PADDING_100,
            ),
            child: NimbusInfoInsightSection(
              title1: StringConst.EVENTS_DESC_SUBTITLE3,
              hasTitle2: false,
              body: StringConst.EVENTS_DESC3,
              title1Style: GoogleFonts.poppins(
                fontSize: Sizes.TEXT_SIZE_28,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBoxH30(),
          Padding(
            padding: EdgeInsets.only(
              left: Sizes.PADDING_100,
              right: Sizes.PADDING_100,
            ),
            child: NimbusInfoInsightSection(
              title1: StringConst.EVENTS_DESC_SUBTITLE4,
              hasTitle2: false,
              body: StringConst.EVENTS_DESC4,
              title1Style: GoogleFonts.poppins(
                fontSize: Sizes.TEXT_SIZE_28,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBoxH30(),
          Padding(
            padding: EdgeInsets.only(
              left: Sizes.PADDING_100,
              right: Sizes.PADDING_100,
            ),
            child: NimbusInfoInsightSection(
              title1: StringConst.EVENTS_DESC_SUBTITLE5,
              hasTitle2: false,
              body: StringConst.EVENTS_DESC5,
              title1Style: GoogleFonts.poppins(
                fontSize: Sizes.TEXT_SIZE_28,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBoxH50(),
        ],
      ),
    );
  }
}

//Mobile Screen
class MobileEventsDescSection extends StatefulWidget {
  const MobileEventsDescSection({Key? key}) : super(key: key);

  @override
  State<MobileEventsDescSection> createState() => _MobileEventsDescSectionState();
}

class _MobileEventsDescSectionState extends State<MobileEventsDescSection> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBoxH10(),
          Padding(
            padding: const EdgeInsets.only(
              left: Sizes.PADDING_20,
              right: Sizes.PADDING_20,
            ),
            child: NimbusInfoInsightSection(
              title1: '',
              hasTitle2: false,
              body: StringConst.ARTICLE_DESC1,
            ),
          ),
          SizedBoxH30(),
          Padding(
            padding: const EdgeInsets.only(
              left: Sizes.PADDING_20,
              right: Sizes.PADDING_20,
            ),
            child: NimbusInfoInsightSection(
              title1: StringConst.ARTICLE_DESC_SUBTITLE2,
              hasTitle2: false,
              body: StringConst.ARTICLE_DESC2,
              title1Style: GoogleFonts.poppins(
                fontSize: Sizes.TEXT_SIZE_18,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBoxH30(),
          Padding(
            padding: const EdgeInsets.only(
              left: Sizes.PADDING_20,
              right: Sizes.PADDING_20,
            ),
            child: NimbusInfoInsightSection(
              title1: StringConst.ARTICLE_DESC_SUBTITLE3,
              hasTitle2: false,
              body: StringConst.ARTICLE_DESC3,
              title1Style: GoogleFonts.poppins(
                fontSize: Sizes.TEXT_SIZE_18,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBoxH30(),
          Padding(
            padding: const EdgeInsets.only(
              left: Sizes.PADDING_20,
              right: Sizes.PADDING_20,
            ),
            child: NimbusInfoInsightSection(
              title1: StringConst.ARTICLE_DESC_SUBTITLE4,
              hasTitle2: false,
              body: StringConst.ARTICLE_DESC4,
              title1Style: GoogleFonts.poppins(
                fontSize: Sizes.TEXT_SIZE_18,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBoxH30(),
          Padding(
            padding: const EdgeInsets.only(
              left: Sizes.PADDING_20,
              right: Sizes.PADDING_20,
            ),
            child: NimbusInfoInsightSection(
              title1: StringConst.ARTICLE_DESC_SUBTITLE5,
              hasTitle2: false,
              body: StringConst.ARTICLE_DESC5,
              title1Style: GoogleFonts.poppins(
                fontSize: Sizes.TEXT_SIZE_18,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
          ),
          SizedBoxH50(),
        ],
      ),
    );
  }
}
