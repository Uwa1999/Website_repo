import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/clients_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/components/alternative_deliveries_solution.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/components/banking_technology.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/components/regulatory_and_services.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/about/about_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/aboutv2/aboutv2.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/aboutv2/components/mission_vision_page.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/insightsv2/insightscreen.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/our_location_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/homepage_screen.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articles/article_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articles/article_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv2/articlev2main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv2/components/articleinside.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv2/components/aticleSectionv2.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/events/event_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/insights_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/insights_section.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/webinars/news_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/alternative_solution_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/banking_technology/banking_technology_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/product_and_services_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/regulatory_security/regulatory_security_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/software_service/software_service_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/products_and_services_v2/products_and_servicesv2.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:layout/layout.dart';

void main() {
  runApp(Fdsap());
}

class Fdsap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp(
        title: 'FDS ASYA PHILIPPINES INC.',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.black54),
        ),
        initialRoute: HomepageScreen.route,
        routes: {
          HomepageScreen.route: (context) => HomepageScreen(),
          AboutMain.route: (context) => AboutMain(),
          ProductServicesMain.route: (context) => ProductServicesMain(),
          // InsightsMain.route: (context) => InsightsMain(),
          BankingTechnologyMain.route: (context) => BankingTechnologyMain(),
          AlternativeSolutionMain.route: (context) => AlternativeSolutionMain(),
          RegulatorySecurityMain.route: (context) => RegulatorySecurityMain(),
          SoftwareServiceMain.route: (context) => SoftwareServiceMain(),
          ArticleDescMain.route: (context) => ArticleDescMain(),
          EventsDescMain.route: (context) => EventsDescMain(),
          NewsDescMain.route: (context) => NewsDescMain(),
          ContactUsPage.route:(context) => ContactUsPage(),
          ClientsList.route:(context)=>ClientsList(),
          // FinTechPage.route:(context)=>FinTechPage(),
          AlternativeDeliveriesSolution.route:(context)=> AlternativeDeliveriesSolution(),
          MFIPage.route:(context)=>MFIPage(),
          ProductsAndServicesV2.route:(context)=> ProductsAndServicesV2(),
          BankingTechnology.route:(context)=> BankingTechnology(),
          AboutUsSectionv2.route:(context)=> AboutUsSectionv2(),
          InsightPage.route:(context) => InsightPage(),
          MissionVision.route:(context)=> MissionVision(),
          InsightSection.route:(context)=> InsightSection(),
          ArticleDescMainv2.route:(context)=> ArticleDescMainv2(),
          ArticleDescSection.route:(context)=> ArticleDescSection()

          // GoogleLikeSearchPage.route:(context)=> GoogleLikeSearchPage()
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
