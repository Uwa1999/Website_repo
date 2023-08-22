import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/footer_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/product_services_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/components/product_services_sidemenu.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/header_section.dart';
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
        child: const HomepageSideMenu(),
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
              children: [
                HeaderSection(),
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
