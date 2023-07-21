import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/regulatory_security/amla/amla_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/regulatory_security/cyber_security/cyber_security_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/regulatory_security/fraud_detection/fraud_detection_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/regulatory_security/security_operation/security_operation_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_builder/responsive_builder.dart';

class RegulatorySecurityMain extends StatefulWidget {
  const RegulatorySecurityMain({Key? key}) : super(key: key);

  @override
  State<RegulatorySecurityMain> createState() => _RegulatorySecurityMainState();
}

class _RegulatorySecurityMainState extends State<RegulatorySecurityMain> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  bool isFabVisible = false;
  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels < 100) {
        _controller.reverse();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = heightOfScreen(context);
    double spacerHeight = screenHeight * 0.19;
    return Scaffold(
      backgroundColor: AppColors.white,
      key: _scaffoldKey,
      floatingActionButton: Visibility(
        visible: isFabVisible,
        child: FloatingActionButton(
          backgroundColor: AppColors.maroon08,
          child: Icon(
            Icons.expand_more,
            size: Sizes.ICON_SIZE_18,
            color: AppColors.white,
          ),
          onPressed: () {},
        ),
      ),
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.direction == ScrollDirection.reverse) {
            if (!isFabVisible) setState(() => isFabVisible = true);
          } else if (notification.direction == ScrollDirection.forward) {
            if (isFabVisible) setState(() => isFabVisible = false);
          }
          return true;
        },
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        //   child: Icon(
        //     FontAwesomeIcons.arrowDown,
        //     size: Sizes.ICON_SIZE_18,
        //     color: AppColors.white,
        //   ),
        // ),
        child: Column(
          children: [
            ResponsiveBuilder(
              refinedBreakpoints: RefinedBreakpoints(),
              builder: (context, sizingInformation) {
                double screenWidth = sizingInformation.screenSize.width;
                if (screenWidth < RefinedBreakpoints().desktopSmall) {
                  return NavSectionMobile(scaffoldKey: _scaffoldKey);
                } else {
                  return HeaderSection();
                }
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    AmlaSection(),
                    CyberSecuritySection(),
                    SecurityOperationSection(),
                    FraudDetectionSection(),
                    SizedBoxH100(),
                    FooterSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
