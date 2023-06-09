import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/amla/amla_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/api/api_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/atm_switch/atm_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/bakawan/bakawan_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/chatbot/chatbot_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/cloud/cloud_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/core_banking/core_banking_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/dcm/dcm_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/k2c/k2c_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/kplus/kplus_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/minokawa/minokawa_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/mobcol/mobcol_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/sbs/sbs_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/temenos/temenos_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/web/web_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/data.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/project_item.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:visibility_detector/visibility_detector.dart';

const double kSpacing = 20.0;
const double kRunSpacing = 16.0;

class ProductServicesCategoryData {
  final String title;
  final int number;
  bool isSelected;

  ProductServicesCategoryData({required this.title, required this.number, this.isSelected = false});
}

class ProductServicesSection extends StatefulWidget {
  ProductServicesSection({Key? key});

  @override
  _ProductServicesSectionState createState() => _ProductServicesSectionState();
}

class _ProductServicesSectionState extends State<ProductServicesSection> with SingleTickerProviderStateMixin {
  late AnimationController _productController;
  late Animation<double> _projectScaleAnimation;
  List<List<ProductServicesData>> productServices = [
    Data.allProductServices,
    // Data.mobileProductServices,
    // Data.webProductServices,
    // Data.atmProductServices,
    // Data.dcmProductServices,
  ];
  late List<ProductServicesData> selectedProductServices;
  late List<ProductServicesCategoryData> productServicesCategories;

  @override
  void initState() {
    super.initState();
    selectedProductServices = productServices[0];

    _productController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _projectScaleAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _productController,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  @override
  void dispose() {
    _productController.dispose();
    super.dispose();
  }

  Future<void> _playProjectAnimation() async {
    try {
      await _productController.forward().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because it was disposed of
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = widthOfScreen(context) - (getSidePadding(context) * 2);
    double contentAreaWidth = screenWidth;
    return VisibilityDetector(
      key: Key('project-section-sm'),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 20) {
          _playProjectAnimation();
        }
      },
      child: ResponsiveBuilder(
        refinedBreakpoints: RefinedBreakpoints(),
        builder: (context, sizingInformation) {
          double screenWidth = sizingInformation.screenSize.width;
          if (screenWidth < (RefinedBreakpoints().tabletLarge)) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: getSidePadding(context)),
              child: ContentArea(
                width: contentAreaWidth,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildProductServicesInfoSm(),
                    SizedBoxH40(),
                    // Wrap(
                    //   spacing: kSpacing,
                    //   runSpacing: kRunSpacing,
                    //   children: _buildProductServicesCategories(productServicesCategories),
                    // ),
                    SizedBoxH40(),
                    Wrap(
                      runSpacing: assignHeight(context, 0.05),
                      children: _buildProductServices(
                        selectedProductServices,
                        isMobile: true,
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return VisibilityDetector(
              key: Key('project-section_lg'),
              onVisibilityChanged: (visibilityInfo) {
                double visiblePercentage = visibilityInfo.visibleFraction * 100;
                if (visiblePercentage > 40) {
                  _playProjectAnimation();
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBoxH80(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getSidePadding(context),
                    ),
                    child: ContentArea(
                      width: contentAreaWidth,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ContentArea(
                            width: contentAreaWidth * 0.7,
                            child: _buildProductServicesInfoLg(),
                          ),
                          SizedBoxW100(),
                          SizedBoxW100(),
                        ],
                      ),
                    ),
                  ),
                  SizedBoxH40(),
                  SizedBoxW5(),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: new ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            //  itemCount: productServicesCategories.length,
                            itemBuilder: (context, index) {
                              return new Container(
                                alignment: Alignment.center,
                                width: widthOfScreen(context),
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: _buildProductServices(selectedProductServices, context: context),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBoxH40(),
                    ],
                  ),
                  SizedBoxW5(),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildProductServicesInfoSm() {
    return NimbusInfoSection2(
      title1: StringConst.PRODUCT_AND_SERVICES,
      hasTitle2: false,
      body: StringConst.PRODUCT_AND_SERVICES_DESC,
    );
  }

  Widget _buildProductServicesInfoLg() {
    return NimbusInfoSection1(
      title1: StringConst.PRODUCT_AND_SERVICES,
      hasTitle2: false,
      body: StringConst.PRODUCT_AND_SERVICES_DESC,
      // child: Wrap(
      //   spacing: kSpacing,
      //   runSpacing: kRunSpacing,
      //   children: _buildProductServicesCategories(productServicesCategories),
      // ),
    );
  }

  // List<Widget> _buildProductServicesCategories(List<ProductServicesCategoryData> categories) {
  //   List<Widget> items = [];
  //   for (int index = 0; index < categories.length; index++) {
  //     items.add(
  //       ProductServicesCategory(
  //         title: categories[index].title,
  //         number: categories[index].number,
  //         isSelected: categories[index].isSelected,
  //         onTap: () => onProductServicesCategoryTap(index),
  //       ),
  //     );
  //   }
  //   return items;
  // }

  List<Widget> _buildProductServices(List<ProductServicesData> data, {bool isMobile = false, context}) {
    List<Widget> items = [];
    List<VoidCallback> functions = [
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatbotDescMain()));
        print('-----CHATBOT SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => kPlusDescMain()));
        print('-----KPLUS SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => K2cDescMain()));
        print('-----KONEK2CARD SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DcmDescMain()));
        print('-----DCM SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MobColDescMain()));
        print('-----MOBILE COLLECTION SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebCollectionDescMain()));
        print('-----WEB COLLECTION SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MinokawaDescMain()));
        print('-----MINOKAWA SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BakawanDescMain()));
        print('-----BAKAWAN SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CoreBankingDescMain()));
        print('-----CORE BANKING SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AmlaDescMain()));
        print('-----AMLA SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AtmDescMain()));
        print('-----ATM SWITCH SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TemenosDecsMain()));
        print('-----TEMENOS SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ApiDescMain()));
        print('-----OPEN API SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SbsDescMain()));
        print('-----SMART BRANCH SYSTEM SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CloudDescMain()));
        print('-----CLOUD TEST ENVIRONMENT SCREEN-----');
      },
    ];
    for (int index = 0; index < data.length; index++) {
      items.add(
        ScaleTransition(
          scale: _projectScaleAnimation,
          child: ProductServicesItem(
            width: isMobile ? assignWidth(context, data[index].mobileWidth) : assignWidth(context, data[index].width),
            height: isMobile ? assignHeight(context, data[index].mobileHeight) : assignHeight(context, data[index].height),
            bannerHeight: isMobile ? assignHeight(context, data[index].mobileHeight) / 2 : assignHeight(context, data[index].height) / 3,
            imageUrl: data[index].productServicesCoverUrl,
            onTap: functions[index],
            // title: data[index].title,
            //  subtitle: data[index].category,
          ),
        ),
      );
    }
    return items;
  }

  void onProductServicesCategoryTap(index) {
    _productController.reset();
    changeCategorySelected(index);
    setState(() {
      selectedProductServices = productServices[index];
      _playProjectAnimation();
    });
  }

  changeCategorySelected(int selectedIndex) {
    for (int index = 0; index < productServicesCategories.length; index++) {
      if (index == selectedIndex) {
        setState(() {
          productServicesCategories[selectedIndex].isSelected = true;
        });
      } else {
        productServicesCategories[index].isSelected = false;
      }
    }
  }
}

class ProductServicesCategory extends StatefulWidget {
  ProductServicesCategory({
    required this.title,
    required this.number,
    this.titleColor = AppColors.black,
    this.numberColor = Colors.transparent,
    this.hoverColor = AppColors.maroon450,
    this.titleStyle,
    this.numberStyle,
    this.onTap,
    this.isSelected = false,
  });

  final String title;
  final Color titleColor;
  final Color numberColor;
  final TextStyle? titleStyle;
  final int number;
  final Color hoverColor;
  final TextStyle? numberStyle;
  final GestureTapCallback? onTap;
  final bool isSelected;

  @override
  _ProductServicesCategoryState createState() => _ProductServicesCategoryState();
}

class _ProductServicesCategoryState extends State<ProductServicesCategory> with SingleTickerProviderStateMixin {
  bool _isHovering = false;

  late AnimationController _controller;
  late Color color;

  @override
  void initState() {
    super.initState();
    color = widget.titleColor;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final hoveredTransform = Matrix4.identity()..translate(0, -8, 0);
    final transform = _isHovering ? hoveredTransform : Matrix4.identity();

    return MouseRegion(
      onEnter: (event) => _mouseEnter(true),
      onExit: (event) => _mouseEnter(false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: transform,
        child: InkWell(
          onTap: widget.onTap,
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.title,
                  style: widget.titleStyle?.copyWith(
                        color: colorOfCategory(),
                      ) ??
                      textTheme.titleMedium?.copyWith(
                        fontSize: Sizes.TEXT_SIZE_16,
                        color: colorOfCategory(),
                      ),
                ),
                // WidgetSpan(
                //   child: widget.isSelected
                //       ? numberOfProductServicesItems()
                //       : FadeTransition(
                //           opacity: _controller.view,
                //           child: numberOfProductServicesItems(),
                //         ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget numberOfProductServicesItems() {
  //   TextTheme textTheme = Theme.of(context).textTheme;
  //   return Transform.translate(
  //     offset: const Offset(2, -8),
  //     child: Text(
  //       "(${widget.number})",
  //       textScaleFactor: 0.7,
  //       style: widget.numberStyle?.copyWith(
  //             color: widget.hoverColor,
  //           ) ??
  //           textTheme.titleMedium?.copyWith(
  //             fontSize: Sizes.TEXT_SIZE_16,
  //             color: widget.hoverColor,
  //           ),
  //     ),
  //   );
  // }

  void _mouseEnter(bool hovering) {
    setState(() {
      this._isHovering = hovering;
    });
    if (hovering) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  Color colorOfSuperScript() {
    if (_isHovering) {
      return widget.hoverColor;
    } else if (widget.isSelected) {
      return widget.hoverColor;
    } else {
      return widget.numberColor;
    }
  }

  Color colorOfCategory() {
    if (_isHovering) {
      return widget.hoverColor;
    } else if (widget.isSelected) {
      return widget.hoverColor;
    } else {
      return widget.titleColor;
    }
  }
}
