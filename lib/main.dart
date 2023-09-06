import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/about/about_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/homepage_screen.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articles/article_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/events/event_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/insights_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/webinars/news_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/alternative_solution_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/banking_technology/banking_technology_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/product_and_services_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/regulatory_security/regulatory_security_main.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/software_service/software_service_main.dart';
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
        home: HomepageScreen(),
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.black54),
        ),
        initialRoute: HomepageScreen.route,
        routes: {
          HomepageScreen.route: (context) => HomepageScreen(),
          AboutMain.route: (context) => AboutMain(),
          ProductServicesMain.route: (context) => ProductServicesMain(),
          InsightsMain.route: (context) => InsightsMain(),
          BankingTechnologyMain.route: (context) => BankingTechnologyMain(),
          AlternativeSolutionMain.route: (context) => AlternativeSolutionMain(),
          RegulatorySecurityMain.route: (context) => RegulatorySecurityMain(),
          SoftwareServiceMain.route: (context) => SoftwareServiceMain(),
          ArticleDescMain.route: (context) => ArticleDescMain(),
          EventsDescMain.route: (context) => EventsDescMain(),
          NewsDescMain.route: (context) => NewsDescMain(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
