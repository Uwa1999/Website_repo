import 'dart:convert';

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
import 'package:http/http.dart' as http;


class OurLocationSection extends StatelessWidget {
  const OurLocationSection({Key? key}) : super(key: key);

  static const String _imagePath = 'assets/images/location.png';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 700,
          height: 500,
          decoration: const BoxDecoration(
            // color: Colors.transparent, // <-- No background
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          child: InkWell(
            hoverColor: Colors.transparent,
            onTap: _launchDesktopURLv2,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                _imagePath,
                fit: BoxFit.cover, // optional: can adjust to fit your design
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const SizedBox(
          width: 500,
          child: CopyAddressWidget(),
        )
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
  static const String route = '/ContactUs';
  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController inquiryController = TextEditingController();
  String? companyType;
  bool isChecked = false;
  bool _isSubmitting = false;

  List<dynamic> _companyTypes = [];
  bool _isLoadingCompanyTypes = true;

  @override
  void initState() {
    _fetchCompanyTypes();
    super.initState();
  }

  void _showTopSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : const Color(0xFF630606),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery
              .of(context)
              .size
              .height - 100,
          left: 550,
          right: 550,
        ),
        duration: const Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
  bool get _allFieldsFilled {
    return firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        companyController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        companyType != null;
  }
  void _validateFieldsBeforeCheck() {
    final missingFields = <String>[];

    if (firstNameController.text.isEmpty) missingFields.add('First Name');
    if (lastNameController.text.isEmpty) missingFields.add('Last Name');
    if (companyController.text.isEmpty) missingFields.add('Company Name');
    if (emailController.text.isEmpty) missingFields.add('Company Email');
    if (phoneController.text.isEmpty) missingFields.add('Phone Number');
    if (companyType == null) missingFields.add('Company Type');

    if (missingFields.isNotEmpty) {
      _showTopSnackBar(
        'Please fill in all fields: ${missingFields.join(', ')}',
        isError: true,
      );
    }
  }

  Future<void> _submitForm() async {
    if (!isChecked) {
      _showTopSnackBar(
          'Please agree to the terms before submitting', isError: true);
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://dev-api-janus.fortress-asya.com:18043/api/public/v1/subscribers/subscribe'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "company": companyController.text,
          "email": emailController.text,
          "phone_number": phoneController.text,
          "company_type": companyType ?? "Startup",
          "client_message" : inquiryController.text
        }),
      );

      final responseData = response.body.isNotEmpty ? jsonDecode(response.body) : {};

      if (response.statusCode == 200 || response.statusCode == 204) {
        _showTopSnackBar(
            responseData['message'] ?? 'Thank you for contacting us!');

        // Clear form
        firstNameController.clear();
        lastNameController.clear();
        companyController.clear();
        emailController.clear();
        phoneController.clear();
        setState(() {
          companyType = null;
          isChecked = false;
        });
      } else if (response.statusCode == 401) {
        // Handle existing email case specifically
        _showTopSnackBar(
            responseData['message'] ?? 'This email is already registered',
            isError: true);
      } else {
        _showTopSnackBar(
            responseData['message'] ?? 'Failed to submit form. Please try again.',
            isError: true);
      }
    } on FormatException {
      _showTopSnackBar('Invalid server response', isError: true);
    } catch (e) {
      _showTopSnackBar(
          'An error occurred. Please check your connection.', isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<void> _fetchCompanyTypes() async {
    try {
      final response = await http.get(
        Uri.parse('https://dev-api-janus.fortress-asya.com:18043/api/public/v1/contact-us/company-type'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final List<dynamic> typesData = jsonResponse['data'];
        setState(() {
          _companyTypes = typesData;
          _isLoadingCompanyTypes = false;
        });
      } else {
        print('Failed to load company types: ${response.statusCode}');
        setState(() {
          _isLoadingCompanyTypes = false;
        });
      }
    } catch (e) {
      print('Error fetching company types: $e');
      setState(() {
        _isLoadingCompanyTypes = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;
        double fieldWidth = isMobile ? double.infinity : (constraints.maxWidth /
            2) - 24;

        return Material(
          color: Colors.transparent,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
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

                  /// 👇 Responsive Name Fields
                  Container(
                    width: 900,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 16,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        SizedBox(
                          width: fieldWidth - 5,
                          child: _buildTextField(
                            controller: firstNameController,
                            hintText: 'First Name',
                            validatorText: 'Please enter your firstname.',
                          ),
                        ),
                        SizedBox(
                          width: fieldWidth - 5,
                          child: _buildTextField(
                            controller: lastNameController,
                            hintText: 'Last Name',
                            validatorText: 'Please enter your lastname.',
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 👇 Other Fields
                  SizedBox(
                    width: double.infinity,
                    child: _buildTextField(
                      controller: companyController,
                      hintText: 'Company Name',
                      validatorText: 'Please enter your company name.',
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: _buildTextField(
                      controller: emailController,
                      hintText: 'Company Email',
                      validatorText: 'Please enter your company email.',
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: _buildTextField(
                      controller: phoneController,
                      hintText: 'Phone Number',
                      validatorText: 'Please enter your phone number.',
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: _buildTextField(
                      controller: inquiryController,
                      hintText: 'Your concern here',
                      validatorText: 'Please enter your inquiries.',
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: _isLoadingCompanyTypes
                        ? const Center(child: CircularProgressIndicator())
                        : _companyTypes.isEmpty
                        ? const Center(child: Text('No company types available.'))
                        : DropdownButtonFormField<String>(
                      value: companyType,
                      decoration: InputDecoration(
                        labelText: 'Company Type',
                        labelStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.black
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black)
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      items: _companyTypes.map((type) {
                        return DropdownMenuItem<String>(
                          value: type['name'],
                          child: Text(type['name']),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          companyType = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      if (!_allFieldsFilled) {
                        _validateFieldsBeforeCheck();
                      }
                    },
                    child: AbsorbPointer(
                      absorbing: !_allFieldsFilled,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: _allFieldsFilled
                                ? (val) {
                              setState(() {
                                isChecked = val ?? false;
                              });
                            }
                                : null,
                            activeColor: AppColors.maroon01,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                'By submitting this form, you agree to allow FDS ASYA PHILIPPINES INC. to store and process the personal information provided above to contact you about our products and services.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: !_allFieldsFilled ? Colors.grey : null,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Submit Button - keeping your exact design
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF400000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    ),
                    onPressed: _allFieldsFilled && isChecked && !_isSubmitting
                        ? _submitForm
                        : null,
                    child: _isSubmitting
                        ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                    )
                        : const Text(
                      'Contact Us',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Keep your existing _buildTextField method exactly as is
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
      cursorColor: Colors.black,
      cursorWidth: 1,
      cursorHeight: 15,
      cursorRadius: const Radius.circular(10),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 5, left: 10, right: 15),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 12),
      ),
      validator: (value) => value!.isEmpty ? validatorText : null,
    );
  }
}