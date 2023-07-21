import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/productservices_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/responsive_navigation/nav_section_mobile.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/header_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ProductServicesMain extends StatefulWidget {
  const ProductServicesMain({Key? key}) : super(key: key);

  @override
  State<ProductServicesMain> createState() => _ProductServicesMainState();
}

class _ProductServicesMainState extends State<ProductServicesMain> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
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
                  ProductServicesSection(),
                  SizedBoxH100(),
                  FooterSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
