import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/alternative_solution_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/banking_technology/banking_technology_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/regulatory_security/regulatory_security_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/software_service/software_service_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/responsive.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/colors.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/data.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/sizes.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/styles.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/content_area.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nimbus_info_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/project_data.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

class ProductAndServicesSection extends StatelessWidget {
  const ProductAndServicesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (!isMobile(context)) == (!isTab(context)) ? DesktopProductServicesSection() : MobileProductServicesSection();
  }
}

//Desktop Screen
class DesktopProductServicesSection extends StatefulWidget {
  DesktopProductServicesSection({Key? key});

  @override
  _DesktopProductServicesSectionState createState() => _DesktopProductServicesSectionState();
}

class _DesktopProductServicesSectionState extends State<DesktopProductServicesSection> with SingleTickerProviderStateMixin {
  late AnimationController _productController;
  late Animation<double> _projectScaleAnimation;
  List<List<DesktopProductServicesData>> productServices = [
    Data.allProductServices,
  ];
  late List<DesktopProductServicesData> selectedProductServices;
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
                    width: contentAreaWidth * 0.8,
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
                    itemBuilder: (context, index) {
                      return new Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getSidePadding(context),
                        ),
                        alignment: Alignment.center,
                        width: widthOfScreen(context),
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: _buildDesktopProductServices(
                            selectedProductServices,
                            context: context,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductServicesInfoSm() {
    return NimbusInfoSection2(
      title1: StringConst.PRODUCT_AND_SERVICES,
      hasTitle2: false,
      body: StringConst.PRODUCT_AND_SERVICES_DESC,
      title1Style: GoogleFonts.poppins(
        fontSize: Sizes.TEXT_SIZE_18,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
    );
  }

  Widget _buildProductServicesInfoLg() {
    return NimbusInfoSection1(
      title1: StringConst.PRODUCT_AND_SERVICES,
      hasTitle2: false,
      body: StringConst.PRODUCT_AND_SERVICES_DESC,
      title1Style: GoogleFonts.poppins(
        fontSize: Sizes.TEXT_SIZE_35,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
    );
  }

  List<Widget> _buildDesktopProductServices(List<DesktopProductServicesData> data, {bool isMobile = false, context}) {
    List<Widget> items = [];
    List<VoidCallback> functions = [
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BankingTechnologyMain()));
        print('-----BANKING TECHNOLOGY SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AlternativeSolutionMain()));
        print('-----ALTERNATIVE DELIVERIES SOLUTION SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegulatorySecurityMain()));
        print('-----REGULATORY AND SECURITY SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SoftwareServiceMain()));
        print('-----SOFTWARE AS A SERVICE SCREEN-----');
      },
    ];
    for (int index = 0; index < data.length; index++) {
      items.add(
        ScaleTransition(
          scale: _projectScaleAnimation,
          child: DesktopProductServicesItem(
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
              ],
            ),
          ),
        ),
      ),
    );
  }

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

//Mobile Screen
class MobileProductServicesSection extends StatefulWidget {
  const MobileProductServicesSection({Key? key}) : super(key: key);

  @override
  State<MobileProductServicesSection> createState() => _MobileProductServicesSectionState();
}

class _MobileProductServicesSectionState extends State<MobileProductServicesSection> with SingleTickerProviderStateMixin {
  late AnimationController _productController;
  late Animation<double> _projectScaleAnimation;
  List<List<DesktopProductServicesData>> productServices = [
    Data.allProductServices,
  ];
  late List<DesktopProductServicesData> selectedProductServices;
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
    // double screenWidth = widthOfScreen(context);
    double screenHeight = heightOfScreen(context);
    double contentAreaWidthSm = screenWidth * 1.1;
    double contentAreaHeightSm = screenHeight * 0.6;
    double contentAreaWidthLg = screenWidth * 0.5;

    return VisibilityDetector(
      key: Key('about-section'),
      onVisibilityChanged: (visibilityInfo) {
        double visiblePercentage = visibilityInfo.visibleFraction * 100;
        if (visiblePercentage > 25) {
          // _scaleController.forward();
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: ResponsiveBuilder(
              refinedBreakpoints: RefinedBreakpoints(),
              builder: (context, sizingInformation) {
                double screenWidth = sizingInformation.screenSize.width;
                if (screenWidth < (RefinedBreakpoints().tabletLarge)) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 20),
                        child: ContentArea(
                          width: contentAreaWidthSm,
                          child: _buildMobileProductServicesInfoSm(
                            width: contentAreaWidthSm,
                            height: contentAreaHeightSm,
                          ),
                        ),
                      ),
                      SizedBoxH10(),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, left: 10),
                        child: ContentArea(
                          child: _buildMobileProductServicesIcon(
                            width: contentAreaWidthSm,
                            height: contentAreaHeightSm,
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getSidePadding(context),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBoxH50(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ContentArea(
                              //width: contentAreaWidthSm,
                              child: _buildMobileProductServicesInfoSm(
                                width: contentAreaWidthSm,
                                height: contentAreaHeightSm,
                              ),
                            ),
                          ],
                        ),
                        SizedBoxH10(),
                        ContentArea(
                          // width: contentAreaWidthSm,
                          child: _buildTabProductServicesIcon(
                            width: contentAreaWidthSm,
                            height: contentAreaHeightSm,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileProductServicesIcon({required double width, required double height}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double fontSize = responsiveSize(context, 60, 72, md: 64);
    TextStyle? titleStyle = textTheme.bodySmall?.merge(
      Styles.customTextStyle3(fontSize: fontSize, height: 1.25),
    );

    return Stack(
      children: [
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
                  itemBuilder: (context, index) {
                    return new Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getSidePadding(context),
                      ),
                      alignment: Alignment.center,
                      width: widthOfScreen(context),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _buildMobileProductServices(
                          selectedProductServices,
                          context: context,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            //    SizedBoxH40(),
          ],
        ),
      ],
    );
  }

  Widget _buildTabProductServicesIcon({required double width, required double height}) {
    TextTheme textTheme = Theme.of(context).textTheme;
    double fontSize = responsiveSize(context, 60, 72, md: 64);
    TextStyle? titleStyle = textTheme.bodySmall?.merge(
      Styles.customTextStyle3(fontSize: fontSize, height: 1.25),
    );

    return Stack(
      children: [
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
                  itemBuilder: (context, index) {
                    return new Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: getSidePadding(context),
                      ),
                      alignment: Alignment.center,
                      width: widthOfScreen(context),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: _buildTabProductServices(
                          selectedProductServices,
                          context: context,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileProductServicesInfoSm({
    required double width,
    required double height,
  }) {
    return Stack(
      children: [
        ResponsiveBuilder(
          refinedBreakpoints: RefinedBreakpoints(),
          builder: (context, sizingInformation) {
            double screenWidth = sizingInformation.screenSize.width;
            if (screenWidth < (RefinedBreakpoints().tabletNormal)) {
              return _buildProductServicesInfoSm(
                width: width,
              );
            } else {
              return Container(
                width: width * 0.80,
                child: _buildProductServicesInfoLg(),
              );
            }
          },
        ),
      ],
    );
  }

  Widget _buildProductServicesInfoSm({required width}) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NimbusInfoSection2(
                title1: StringConst.PRODUCT_AND_SERVICES,
                title1Style: GoogleFonts.poppins(
                  fontSize: Sizes.TEXT_SIZE_18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                ),
                hasTitle2: false,
                body: StringConst.PRODUCT_AND_SERVICES_DESC,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductServicesInfoLg() {
    return NimbusInfoSection1(
      title1: StringConst.PRODUCT_AND_SERVICES,
      hasTitle2: false,
      body: StringConst.PRODUCT_AND_SERVICES_DESC,
      title1Style: GoogleFonts.poppins(
        fontSize: Sizes.TEXT_SIZE_35,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
    );
  }

  List<Widget> _buildMobileProductServicesCategories(List<ProductServicesCategoryData> categories) {
    List<Widget> items = [];
    for (int index = 0; index < categories.length; index++) {
      items.add(
        ProductServicesCategory(
          title: categories[index].title,
          number: categories[index].number,
          isSelected: categories[index].isSelected,
          onTap: () => onMobileProductServicesCategoryTap(index),
        ),
      );
    }
    return items;
  }

  List<Widget> _buildMobileProductServices(List<DesktopProductServicesData> data, {bool isMobile = false, context}) {
    List<Widget> items = [];
    List<VoidCallback> functions = [
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BankingTechnologyMain()));
        print('-----BANKING TECHNOLOGY SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AlternativeSolutionMain()));
        print('-----ALTERNATIVE DELIVERIES SOLUTION SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegulatorySecurityMain()));
        print('-----REGULATORY AND SECURITY SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SoftwareServiceMain()));
        print('-----SOFTWARE AS A SERVICE SCREEN-----');
      },
    ];
    for (int index = 0; index < data.length; index++) {
      items.add(
        MobileProductServicesItem(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.1,
          bannerHeight: MediaQuery.of(context).size.height * 0.2,
          imageUrl: data[index].productServicesCoverUrl,
          onTap: functions[index],
          // title: data[index].title,
          //  subtitle: data[index].category,
        ),
      );
    }
    return items;
  }

  List<Widget> _buildTabProductServices(List<DesktopProductServicesData> data, {bool isMobile = false, context}) {
    List<Widget> items = [];
    List<VoidCallback> functions = [
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => BankingTechnologyMain()));
        print('-----BANKING TECHNOLOGY SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => AlternativeSolutionMain()));
        print('-----ALTERNATIVE DELIVERIES SOLUTION SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegulatorySecurityMain()));
        print('-----REGULATORY AND SECURITY SCREEN-----');
      },
      () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => SoftwareServiceMain()));
        print('-----SOFTWARE AS A SERVICE SCREEN-----');
      },
    ];
    for (int index = 0; index < data.length; index++) {
      items.add(
        TabProductServicesItem(
          width: MediaQuery.of(context).size.width * 0.2,
          height: MediaQuery.of(context).size.height * 0.2,
          bannerHeight: MediaQuery.of(context).size.height * 0.3,
          imageUrl: data[index].productServicesCoverUrl,
          onTap: functions[index],
          // title: data[index].title,
          //  subtitle: data[index].category,
        ),
      );
    }
    return items;
  }

  void onMobileProductServicesCategoryTap(index) {
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

class MobileProductServicesCategory extends StatefulWidget {
  MobileProductServicesCategory({
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
  _MobileProductServicesCategoryState createState() => _MobileProductServicesCategoryState();
}

class _MobileProductServicesCategoryState extends State<MobileProductServicesCategory> with SingleTickerProviderStateMixin {
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
            textAlign: TextAlign.justify,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

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
