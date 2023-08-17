import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
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
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
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
                // gradient: LinearGradient(
                //   begin: Alignment.topLeft,
                //   end: Alignment.bottomRight,
                //   colors: [
                //     AppColors.maroon03.withOpacity(1.0),
                //     AppColors.maroon05.withOpacity(0.8),
                //   ],
                // ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBoxH150(),
                  SizedBoxH150(),
                  SizedBoxH30(),
                  Flexible(
                    fit: FlexFit.loose,
                    child: NimbusInfoSection3(
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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBoxH50(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_100,
                    ),
                    child: NimbusInfoSection4(
                      title1: '',
                      hasTitle2: false,
                      body: StringConst.EVENTS_DESC1,
                    ),
                  ),
                ),
                SizedBoxH20(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_100,
                    ),
                    child: NimbusInfoSection5(
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
                ),
                SizedBoxH20(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_100,
                    ),
                    child: NimbusInfoSection5(
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
                ),
                SizedBoxH20(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_100,
                    ),
                    child: NimbusInfoSection5(
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
                ),
                SizedBoxH20(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_100,
                    ),
                    child: NimbusInfoSection5(
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
                ),
                SizedBoxH50(),
              ],
            ),
          ],
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
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Sizes.PADDING_100,
                right: Sizes.PADDING_150,
              ),
              height: MediaQuery.of(context).size.height * 0.6,
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
                  SizedBoxH150(),
                  SizedBoxH30(),
                  Flexible(
                    fit: FlexFit.loose,
                    child: NimbusInfoSection3(
                      title1: StringConst.EVENTS_DESC_TITLE,
                      hasTitle2: false,
                      body: StringConst.EVENTS_DESC_SUBTITLE1,
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBoxH50(),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_100,
                    ),
                    child: NimbusInfoSection4(
                      title1: '',
                      hasTitle2: false,
                      body: StringConst.EVENTS_DESC1,
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_100,
                    ),
                    child: NimbusInfoSection5(
                      title1: StringConst.EVENTS_DESC_SUBTITLE2,
                      hasTitle2: false,
                      body: StringConst.EVENTS_DESC2,
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_100,
                    ),
                    child: NimbusInfoSection5(
                      title1: StringConst.EVENTS_DESC_SUBTITLE3,
                      hasTitle2: false,
                      body: StringConst.EVENTS_DESC3,
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_100,
                    ),
                    child: NimbusInfoSection5(
                      title1: StringConst.EVENTS_DESC_SUBTITLE4,
                      hasTitle2: false,
                      body: StringConst.EVENTS_DESC4,
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: Sizes.PADDING_100,
                      right: Sizes.PADDING_100,
                    ),
                    child: NimbusInfoSection5(
                      title1: StringConst.EVENTS_DESC_SUBTITLE5,
                      hasTitle2: false,
                      body: StringConst.EVENTS_DESC5,
                      title1Style: GoogleFonts.poppins(
                        fontSize: Sizes.TEXT_SIZE_18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                ),
                SizedBoxH50(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
