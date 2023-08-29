import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsDescSection extends StatefulWidget {
  const EventsDescSection({Key? key}) : super(key: key);

  @override
  State<EventsDescSection> createState() => _EventsDescSectionState();
}

class _EventsDescSectionState extends State<EventsDescSection> {
  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) == (!isTab(context)) ? DesktopEventsDescScreen() : MobileEventsDescScreen();
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
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: Sizes.PADDING_100,
            right: Sizes.PADDING_150,
          ),
          height: MediaQuery.of(context).size.height * 0.7,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(ImagePath.EVENTS_HEADER),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBoxH150(),
              SizedBoxH150(),
              SizedBoxH30(),
              Flexible(
                fit: FlexFit.loose,
                child: NimbusInfoInsightTitle(
                  title1: StringConst.EVENTS_DESC_TITLE,
                  hasTitle2: false,
                  body: StringConst.EVENTS_DESC_SUBTITLE1,
                  title1Style: GoogleFonts.poppins(
                    fontSize: Sizes.TEXT_SIZE_35,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

//Mobile Screen
class MobileEventsDescScreen extends StatefulWidget {
  const MobileEventsDescScreen({Key? key}) : super(key: key);

  @override
  State<MobileEventsDescScreen> createState() => _MobileEventsDescScreenState();
}

class _MobileEventsDescScreenState extends State<MobileEventsDescScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: Sizes.PADDING_20,
            right: Sizes.PADDING_20,
          ),
          height: MediaQuery.of(context).size.height * 0.5,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.maroon03.withOpacity(1.0),
                AppColors.maroon05.withOpacity(0.8),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBoxH130(),
              Flexible(
                fit: FlexFit.loose,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: Sizes.PADDING_20,
                    right: Sizes.PADDING_20,
                  ),
                  child: NimbusInfoInsightTitle(
                    title1: StringConst.EVENTS_DESC_TITLE,
                    hasTitle2: false,
                    body: StringConst.EVENTS_DESC_SUBTITLE1,
                    title1Style: GoogleFonts.poppins(
                      fontSize: Sizes.TEXT_SIZE_18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
