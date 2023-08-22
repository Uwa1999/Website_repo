import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/product_services_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/components/product_services_sidemenu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';

class ProductServicesMain extends StatefulWidget {
  const ProductServicesMain({Key? key}) : super(key: key);

  @override
  State<ProductServicesMain> createState() => _ProductServicesMainState();
}

class _ProductServicesMainState extends State<ProductServicesMain> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      endDrawer: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: const ProductAndServicesSideMenu(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            width: size.width,
            constraints: BoxConstraints(minHeight: size.height),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ProductAndServicesSection(),
                SizedBoxH100(),
                FooterSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
//   final ScrollController _scrollController = ScrollController();
//   final List<NavItemData> navItems = [
//     NavItemData(name: StringConst.HOME, key: GlobalKey(), isSelected: true),
//     NavItemData(name: StringConst.ABOUT, key: GlobalKey()),
//     NavItemData(name: StringConst.SERVICES, key: GlobalKey()),
//     NavItemData(name: StringConst.INSIGHTS, key: GlobalKey()),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       drawer: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 300),
//         child: const ProductAndServicesSideMenu(),
//       ),
//       body: Column(
//         children: [
//           // ResponsiveBuilder(
//           //   refinedBreakpoints: RefinedBreakpoints(),
//           //   builder: (context, sizingInformation) {
//           //     double screenWidth = sizingInformation.screenSize.width;
//           //     if (screenWidth < RefinedBreakpoints().desktopSmall) {
//           //       return NavSectionMobile(scaffoldKey: _scaffoldKey);
//           //     } else {
//           //       return HeaderSection();
//           //     }
//           //   },
//           // ),
//           Expanded(
//             child: SingleChildScrollView(
//               controller: _scrollController,
//               child: Column(
//                 children: [
//                   ProductAndServicesSection(),
//                   SizedBoxH100(),
//                   FooterSection(),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
