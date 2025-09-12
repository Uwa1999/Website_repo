// lib/routes/app_routes.dart

import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articles/article_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/widgets/nav_item.dart';
import 'package:flutter/material.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/auth/login_page.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/auth/registration_page.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/catalogs/products_and_services.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/homepage/dashboard_screen.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/homepage/main_screen.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/insights/add_insight.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/homepage_screen.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/about/about_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/product_and_services_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/banking_technology/banking_technology_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/alternative_solution_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/regulatory_security/regulatory_security_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/software_service/software_service_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articles/article_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/events/event_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/webinars/news_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/our_location_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/clients_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/components/alternative_deliveries_solution.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/components/banking_technology.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/components/regulatory_and_services.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/products_and_services_v2/products_and_servicesv2.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/aboutv2/aboutv2.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/aboutv2/components/mission_vision_page.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/insightsv2/insightscreen.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv2/articlev2main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv2/components/articleinside.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv2/components/aticleSectionv2.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/insights_section.dart';
import 'package:provider/provider.dart';

import 'core/provider/article_provider.dart';

final Map<String, WidgetBuilder> appRoutes = {
  MainScreen.route: (context) => MainScreen(),
  LoginScreen.route: (context) => LoginScreen(),
  RegistrationForm.route: (context) => RegistrationForm(),
  ProductsAndServices.route: (context) => ProductsAndServices(),
  DashboardScreen.route: (context) => DashboardScreen(searchQuery: ''),
  AddInsightForm.route: (context) => AddInsightForm(),
  HomepageScreen.route: (context) => HomepageScreen(),
  AboutMain.route: (context) => AboutMain(),
  ProductServicesMain.route: (context) => ProductServicesMain(),
  BankingTechnologyMain.route: (context) => BankingTechnologyMain(),
  AlternativeSolutionMain.route: (context) => AlternativeSolutionMain(),
  RegulatorySecurityMain.route: (context) => RegulatorySecurityMain(),
  SoftwareServiceMain.route: (context) => SoftwareServiceMain(),
  ArticleDescMain.route: (context) => ArticleDescMain(),
  EventsDescMain.route: (context) => EventsDescMain(),
  NewsDescMain.route: (context) => NewsDescMain(),
  ContactUsPage.route: (context) => ContactUsPage(),
  ClientsList.route: (context) => ClientsList(),
  AlternativeDeliveriesSolution.route: (context) => AlternativeDeliveriesSolution(),
  MFIPage.route: (context) => MFIPage(),
  ProductsAndServicesV2.route: (context) => ProductsAndServicesV2(),
  BankingTechnology.route: (context) => BankingTechnology(),
  AboutUsSectionv2.route: (context) {
    // Extract the arguments passed during navigation.
    final arguments = ModalRoute.of(context)!.settings.arguments;
    // Check if arguments are a List<NavItemData> and pass them to the widget.
    if (arguments is List<NavItemData>) {
      return AboutUsSectionv2(navItems: arguments);
    }
    throw Exception('AboutUsSectionv2 route was called without navItems data.');
  },
  InsightPage.route: (context) => InsightPage(),
  MissionVision.route: (context) => MissionVision(),
  InsightSection.route: (context) => InsightSection(),
  ArticleDescSectionInside.route: (context) => ArticleDescSectionInside(
    title: '', imageUrl: '', remarks: '', date: '',
  ),
  ArticleDescMainv2.route: (context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Get the provider instance
    final articleProvider = Provider.of<ArticleProvider>(context, listen: false);

    return ArticleDescMainv2(
      articleId: args?['articleId'] ?? articleProvider.currentArticleId ?? '',
      initialArticleData: args?['articleData'] ?? articleProvider.articleData,
    );
  },
};

