import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/images.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/address.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:flutter/material.dart';

///old
// class OurLocationSection extends StatefulWidget {
//   const OurLocationSection({Key? key}) : super(key: key);
//
//   @override
//   State<OurLocationSection> createState() => _OurLocationSectionState();
// }
//
// class _OurLocationSectionState extends State<OurLocationSection> {
//   @override
//   Widget build(BuildContext context) {
//     return (!isMobile(context)) == (!isTab(context)) ? DesktopOurLocation() : MobileOurLocation();
//   }
// }

// class DesktopOurLocation extends StatefulWidget {
//   const DesktopOurLocation({Key? key}) : super(key: key);
//
//   @override
//   State<DesktopOurLocation> createState() => _DesktopOurLocationState();
// }
//
// class _DesktopOurLocationState extends State<DesktopOurLocation> {
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = widthOfScreen(context) - getSidePadding(context);
//     double screenHeight = heightOfScreen(context);
//     double contentAreaWidthSm = screenWidth * 1.0;
//     double contentAreaHeightSm = screenHeight * 0.6;
//     double contentAreaWidthLg = screenWidth * 1.2;
//     return VisibilityDetector(
//       key: Key('location-section'),
//       onVisibilityChanged: (visibilityInfo) {
//         double visiblePercentage = visibilityInfo.visibleFraction * 100;
//         if (visiblePercentage > 25) {}
//       },
//       child: Container(
//         padding: EdgeInsets.only(left: getSidePadding(context)),
//         child: ResponsiveBuilder(
//           refinedBreakpoints: RefinedBreakpoints(),
//           builder: (context, sizingInformation) {
//             double screenWidth = sizingInformation.screenSize.width;
//             if (screenWidth < (RefinedBreakpoints().tabletLarge)) {
//               return Column(
//                 children: [
//                   ContentArea(
//                     width: contentAreaWidthSm,
//                     child: _buildLocation(
//                       width: contentAreaWidthSm,
//                       height: screenHeight,
//                     ),
//                   ),
//                   ContentArea(
//                     width: contentAreaWidthSm,
//                     child: _buildMobileLocationImage(
//                       width: contentAreaWidthSm,
//                       height: contentAreaHeightSm,
//                     ),
//                   ),
//                   SizedBoxH50(),
//                 ],
//               );
//             } else {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // SizedBoxH50(),
//                   ContentArea(
//                     width: contentAreaWidthLg,
//                     child: _buildLocation(
//                       width: contentAreaWidthLg,
//                       height: screenHeight,
//                     ),
//                   ),
//                   ContentArea(
//                     width: contentAreaWidthLg,
//                     child: _buildLocationImage(
//                       width: contentAreaWidthLg,
//                       height: screenHeight,
//                     ),
//                   ),
//                   SizedBoxH50(),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildMobileLocationImage({required double width, required double height}) {
//     return Stack(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(
//             right: Sizes.PADDING_30,
//           ),
//           child: ContentArea(
//             width: double.infinity,
//             height: MediaQuery.of(context).size.height * 0.7,
//             backgroundColor: AppColors.maroon03,
//             borderRadius: const BorderRadius.all(
//               Radius.circular(Sizes.RADIUS_8),
//             ),
//             child: ClipRRect(
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(Sizes.RADIUS_8),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: InkWell(
//                   onTap: _launchDesktopURL,
//                   child: Image.asset(
//                     ImagePath.FDSAP_MAP,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLocationImage({required double width, required double height}) {
//     return Stack(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(
//             right: Sizes.PADDING_30,
//           ),
//           child: ContentArea(
//             width: double.infinity,
//             height: MediaQuery.of(context).size.height * 0.7,
//             backgroundColor: AppColors.maroon03,
//             borderRadius: const BorderRadius.all(
//               Radius.circular(Sizes.RADIUS_8),
//             ),
//             child: ClipRRect(
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(Sizes.RADIUS_8),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: InkWell(
//                   onTap: _launchDesktopURL,
//                   child: Image.asset(
//                     ImagePath.FDSAP_MAP,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLocation({
//     required double width,
//     required double height,
//   }) {
//     return Stack(
//       children: [
//         ResponsiveBuilder(
//           refinedBreakpoints: RefinedBreakpoints(),
//           builder: (context, sizingInformation) {
//             double screenWidth = sizingInformation.screenSize.width;
//             if (screenWidth < (RefinedBreakpoints().tabletNormal)) {
//               return nimbusInfoSectionSm(width: width);
//             } else {
//               return Container(
//                 width: width * 0.80,
//                 child: nimbusInfoSectionLg(),
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget nimbusInfoSectionLg() {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(right: !isMobile(context) ? 15 : 0),
//                 child: NimbusInfoSection2(
//                   title1: StringConst.OUR_LOCATION,
//                   hasTitle2: false,
//                   title1Style: GoogleFonts.poppins(
//                     fontSize: Sizes.TEXT_SIZE_35,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.black,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget nimbusInfoSectionSm({required double width}) {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(right: !isMobile(context) ? 15 : 0),
//                 child: NimbusInfoSection2(
//                   title1: StringConst.OUR_LOCATION,
//                   hasTitle2: false,
//                   title1Style: GoogleFonts.poppins(
//                     fontSize: Sizes.TEXT_SIZE_18,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.black,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// _launchDesktopURL() async {
//   print('-----FDSAP GOOGLE MAP LOCATION-----');
//   final Uri url = Uri.parse(StringConst.LOCATION_URL);
//   if (!await launchUrl(url)) {
//     throw Exception('Could not launch');
//   }
// }
//
// class MobileOurLocation extends StatefulWidget {
//   const MobileOurLocation({Key? key}) : super(key: key);
//
//   @override
//   State<MobileOurLocation> createState() => _MobileOurLocationState();
// }
//
// class _MobileOurLocationState extends State<MobileOurLocation> {
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = widthOfScreen(context) - getSidePadding(context);
//     double screenHeight = heightOfScreen(context);
//     double contentAreaWidthSm = screenWidth * 1.1;
//     double contentAreaHeightSm = screenHeight * 0.6;
//     double contentAreaWidthLg = screenWidth * 1.2;
//     return VisibilityDetector(
//       key: Key('location-section'),
//       onVisibilityChanged: (visibilityInfo) {
//         double visiblePercentage = visibilityInfo.visibleFraction * 100;
//         if (visiblePercentage > 25) {}
//       },
//       child: Container(
//         padding: EdgeInsets.only(left: getSidePadding(context)),
//         child: ResponsiveBuilder(
//           refinedBreakpoints: RefinedBreakpoints(),
//           builder: (context, sizingInformation) {
//             double screenWidth = sizingInformation.screenSize.width;
//             if (screenWidth < (RefinedBreakpoints().tabletLarge)) {
//               return Column(
//                 children: [
//                   ContentArea(
//                     width: contentAreaWidthSm,
//                     child: _buildLocation(
//                       width: contentAreaWidthSm,
//                       height: screenHeight,
//                     ),
//                   ),
//                   ContentArea(
//                     width: contentAreaWidthSm,
//                     child: _buildMobileLocationImage(),
//                   ),
//                   SizedBoxH50(),
//                 ],
//               );
//             } else {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   // SizedBoxH50(),
//                   ContentArea(
//                     width: contentAreaWidthLg,
//                     child: _buildLocation(
//                       width: contentAreaWidthLg,
//                       height: screenHeight,
//                     ),
//                   ),
//                   ContentArea(
//                     width: contentAreaWidthLg,
//                     child: _buildLocationImage(
//                       width: contentAreaWidthLg,
//                       height: screenHeight,
//                     ),
//                   ),
//                   SizedBoxH50(),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLocationImage({required double width, required double height}) {
//     return Stack(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(
//             right: Sizes.PADDING_30,
//           ),
//           child: ContentArea(
//             width: double.infinity,
//             height: MediaQuery.of(context).size.height * 0.7,
//             backgroundColor: AppColors.maroon03,
//             borderRadius: const BorderRadius.all(
//               Radius.circular(Sizes.RADIUS_8),
//             ),
//             child: ClipRRect(
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(Sizes.RADIUS_8),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: InkWell(
//                   onTap: _launchMobileURL,
//                   child: Image.asset(
//                     ImagePath.FDSAP_MAP,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildMobileLocationImage() {
//     return Stack(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(
//             right: Sizes.PADDING_30,
//           ),
//           child: ContentArea(
//             width: double.infinity,
//             height: MediaQuery.of(context).size.height * 0.2,
//             backgroundColor: AppColors.maroon03,
//             borderRadius: const BorderRadius.all(
//               Radius.circular(Sizes.RADIUS_10),
//             ),
//             child: ClipRRect(
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(Sizes.RADIUS_18),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(3.0),
//                 child: InkWell(
//                   onTap: _launchDesktopURL,
//                   child: Image.asset(
//                     ImagePath.FDSAP_MAP,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildLocation({
//     required double width,
//     required double height,
//   }) {
//     return Stack(
//       children: [
//         ResponsiveBuilder(
//           refinedBreakpoints: RefinedBreakpoints(),
//           builder: (context, sizingInformation) {
//             double screenWidth = sizingInformation.screenSize.width;
//             if (screenWidth < (RefinedBreakpoints().tabletNormal)) {
//               return nimbusInfoSectionSm(width: width);
//             } else {
//               return Container(
//                 width: width * 0.80,
//                 child: nimbusInfoSectionLg(),
//               );
//             }
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget nimbusInfoSectionLg() {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(right: !isMobile(context) ? 15 : 0),
//                 child: NimbusInfoSection2(
//                   title1: StringConst.OUR_LOCATION,
//                   hasTitle2: false,
//                   title1Style: GoogleFonts.poppins(
//                     fontSize: Sizes.TEXT_SIZE_35,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.black,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget nimbusInfoSectionSm({required double width}) {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Padding(
//                 padding: EdgeInsets.only(right: !isMobile(context) ? 15 : 0),
//                 child: NimbusInfoSection2(
//                   title1: StringConst.OUR_LOCATION,
//                   hasTitle2: false,
//                   title1Style: GoogleFonts.poppins(
//                     fontSize: Sizes.TEXT_SIZE_18,
//                     fontWeight: FontWeight.w700,
//                     color: AppColors.black,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// _launchMobileURL() async {
//   print('-----FDSAP GOOGLE MAP LOCATION-----');
//   final Uri url = Uri.parse(StringConst.LOCATION_URL);
//   if (!await launchUrl(url)) {
//     throw Exception('Could not launch');
//   }
// }
//

class OurLocationSection extends StatelessWidget {
  const OurLocationSection({Key? key}) : super(key: key);

  static const String _imagePath = 'assets/images/location.png';
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Semantics(
        //   header: true,
        //   child: Text(
        //     _title,
        //     style: Theme.of(context).textTheme.headlineSmall?.copyWith(
        //       fontWeight: FontWeight.bold,
        //     ),
        //     textAlign: TextAlign.center,
        //   ),
        // ),
        // const SizedBox(height: 16.0),
        // Text(
        //   _description,
        //   style: Theme.of(context).textTheme.bodyLarge,
        //   textAlign: TextAlign.center,
        // ),
        // const SizedBox(height: 24.0),
        Container(
          width: 700,
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          child: InkWell(
            onTap: _launchDesktopURLv2,
            child: Image.asset(
              _imagePath,
              // fit: BoxFit.fill,
            ),
          ),
        ),
      SizedBox(height: 10,),
      Container(
          width: 500,
          child: CopyAddressWidget())
      ],
    );
  }
}
_launchDesktopURLv2() async {
  print('-----FDSAP GOOGLE MAP LOCATION-----');
  final Uri url = Uri.parse(StringConst.LOCATION_URLv2);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch');
  }
}


class ContactUsPage extends StatefulWidget {
  static const String route = '/Contact Us';
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  String? companyType;
  bool isChecked = false;


  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    companyController.dispose();
    emailController.dispose();
    phoneController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry padding = EdgeInsets.symmetric(horizontal: getSidePadding(context));
    double screenWidth = widthOfScreen(context) - (getSidePadding(context) * 2);
    return Material(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: ContentArea(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                'Start your journey with us.',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Let's build what's next, together.",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 300,
                        child: _buildTextField(
                          controller: firstNameController,
                          hintText: 'First Name',
                          validatorText: 'Please enter your firstname.',
                        ),
                      ),
                      const SizedBox(width: 15),
                      SizedBox(
                        width: 300,
                        child: _buildTextField(
                          controller: lastNameController,
                          hintText: 'Last Name',
                          validatorText: 'Please enter your lastname.',
                        ),
                      ),
                    ],
                  )

                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 615,
                child: _buildTextField(
                  controller: companyController,
                  hintText: 'Company Name',
                  validatorText: 'Please enter your company name.',
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 615,
                child: _buildTextField(
                  controller: emailController,
                  hintText: 'Company Email',
                  validatorText: 'Please enter your company email.',
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 615,
                child: _buildTextField(
                  controller: phoneController,
                  hintText: 'Phone Number',
                  validatorText: 'Please enter your phone number.',
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: 615,
                child: DropdownButtonFormField<String>(
                  value: companyType,
                  decoration: const InputDecoration(labelText: 'Company Type'),
                  items: ['Startup', 'SME', 'Enterprise']
                      .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      companyType = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 615,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (val) {
                        setState(() {
                          isChecked = val ?? false;
                        });
                      },
                      activeColor: AppColors.maroon01,
                    ),
                    const Expanded(
                      child: Text(
                        'By submitting this form, you agree to allow FDS ASYA PHILIPPINES INC. to store and process the personal information provided above to contact you about our products and services.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.brown[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
                onPressed: isChecked ? () {} : null,
                child: const Text('Contact Us', style: TextStyle(color: AppColors.white),),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String validatorText,
  }) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 12),
      textInputAction: TextInputAction.next,
      textAlignVertical: TextAlignVertical.center,
      cursorColor: const Color(0xff1c601f),
      cursorWidth: 1,
      cursorHeight: 15,
      cursorRadius: const Radius.circular(10),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 5, left: 10, right: 15),
        filled: true,
        fillColor: Colors.white10,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff1c601f),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xff1c601f),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 0.6,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 12),
      ),
      validator: (value) => value!.isEmpty ? validatorText : null,
    );
  }
}
