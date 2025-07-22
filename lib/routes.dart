// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/auth/login_page.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/auth/registration_page.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/catalogs/products_and_services.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/homepage/dashboard_screen.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/homepage/main_screen.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/insights/add_insight.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/admin/insights/update_insight.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/clients_main.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/components/alternative_deliveries_solution.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/components/banking_technology.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/clients/components/regulatory_and_services.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/about/about_main.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/aboutv2/aboutv2.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/aboutv2/components/mission_vision_page.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/insightsv2/insightscreen.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/components/our_location_section.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/homepage_screen.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articles/article_main.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articles/article_section.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv2/articlev2main.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv2/components/articleinside.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/articlesv2/components/aticleSectionv2.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/events/event_main.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/insights_main.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/insights_section.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/insights/webinars/news_main.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/alternative_solution/alternative_solution_main.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/banking_technology/banking_technology_main.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/product_and_services_main.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/regulatory_security/regulatory_security_main.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/product_and_services/software_service/software_service_main.dart';
// import 'package:FDS_ASYA_PHILIPPINES/ui/screens/products_and_services_v2/products_and_servicesv2.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// final router = GoRouter(
//   initialLocation: '/AdminLogin',
//   debugLogDiagnostics: true, // Helpful for debugging
//   routes: [
//      GoRoute(
//       path: HomepageScreen.route,
//       name: 'Homepage',
//       builder: (context, state) => HomepageScreen(),
//      ),
//
//       // About section
//       GoRoute(
//         path: AboutMain.route,
//         name: 'AboutUs',
//         builder: (context, state) => const AboutMain(),
//       ),
//       GoRoute(
//         path: AboutUsSectionv2.route,
//         name: 'AboutUsSec',
//         builder: (context, state) => const AboutUsSectionv2(),
//       ),
//       GoRoute(
//         path: MissionVision.route,
//         name: 'Mission&Vision',
//         builder: (context, state) => const MissionVision(),
//       ),
//
//       // Products and Services
//       GoRoute(
//         path: ProductServicesMain.route,
//         name: 'ProductsAndServices',
//         builder: (context, state) => const ProductServicesMain(),
//       ),
//       GoRoute(
//         path: ProductsAndServicesV2.route,
//         name: 'PAS',
//         builder: (context, state) => const ProductsAndServicesV2(),
//       ),
//       GoRoute(
//         path: BankingTechnologyMain.route,
//         name: 'BankingTechnologyMain',
//         builder: (context, state) => const BankingTechnologyMain(),
//       ),
//       GoRoute(
//         path: AlternativeSolutionMain.route,
//         name: 'AlternativeSolution',
//         builder: (context, state) => const AlternativeSolutionMain(),
//       ),
//       GoRoute(
//         path: RegulatorySecurityMain.route,
//         name: 'RegulatoryAndSecurity',
//         builder: (context, state) => const RegulatorySecurityMain(),
//       ),
//       GoRoute(
//         path: SoftwareServiceMain.route,
//         name: 'SoftwareServices',
//         builder: (context, state) => const SoftwareServiceMain(),
//       ),
//
//       // Insights
//       GoRoute(
//         path: InsightPage.route,
//         name: 'Insights',
//         builder: (context, state) => const InsightPage(),
//       ),
//       GoRoute(
//         path: InsightsMain.route,
//         name: 'InsightsMain',
//         builder: (context, state) => const InsightsMain(),
//       ),
//       GoRoute(
//         path: InsightSection.route,
//         name: 'InsightsSection',
//         builder: (context, state) => const InsightSection(),
//       ),
//
//       // Articles
//       GoRoute(
//         path: ArticleDescMain.route,
//         name: 'ArticleDescMain',
//         builder: (context, state) => const ArticleDescMain(),
//       ),
//       GoRoute(
//         path: ArticleDescMainv2.route,
//         name: 'ArticleDescription',
//         builder: (context, state) {
//           final args = state.extra as Map<String, dynamic>?;
//           return ArticleDescMainv2(
//             articleId: args?['articleId'] ?? '',
//             initialArticleData: args?['articleData'],
//           );
//         },
//       ),
//       GoRoute(
//         path: ArticleDescSectionInside.route,
//         name: 'ArticleInside',
//         builder: (context, state) {
//           final args = state.extra as Map<String, dynamic>?;
//           return ArticleDescSectionInside(
//             title: args?['title'] ?? '',
//             imageUrl: args?['imageUrl'] ?? '',
//             remarks: args?['remarks'] ?? '',
//             date: args?['date'] ?? '',
//           );
//         },
//       ),
//
//       // Clients
//       GoRoute(
//         path: ClientsList.route,
//         name: 'ClientsList',
//         builder: (context, state) => const ClientsList(),
//       ),
//       GoRoute(
//         path: AlternativeDeliveriesSolution.route,
//         name: 'ADS',
//         builder: (context, state) => const AlternativeDeliveriesSolution(),
//       ),
//       GoRoute(
//         path: BankingTechnology.route,
//         name: 'BankingTechnology',
//         builder: (context, state) => const BankingTechnology(),
//       ),
//       GoRoute(
//         path: MFIPage.route,
//         name: 'MfisPage',
//         builder: (context, state) => const MFIPage(),
//       ),
//
//       // Contact
//       GoRoute(
//         path: ContactUsPage.route,
//         name: 'ContactUs',
//         builder: (context, state) => ContactUsPage(),
//       ),
//
//       // Admin routes
//       GoRoute(
//         path: LoginScreen.route,
//         name: 'AdminLogin',
//         builder: (context, state) => const LoginScreen(),
//       ),
//       GoRoute(
//         path: RegistrationForm.route,
//         name: 'AdminRegistration',
//         builder: (context, state) => const RegistrationForm(),
//       ),
//       GoRoute(
//         path: MainScreen.route,
//         name: 'AdminMainScreen',
//         builder: (context, state) => const MainScreen(),
//       ),
//       GoRoute(
//         path: DashboardScreen.route,
//         name: 'AdminDashboard',
//         builder: (context, state) => DashboardScreen(searchQuery: ''),
//       ),
//       GoRoute(
//         path: ProductsAndServices.route,
//         name: 'AdminProductsAndServices',
//         builder: (context, state) => const ProductsAndServices(),
//       ),
//       GoRoute(
//         path: AddInsightForm.route,
//         name: 'AdminAddInsights',
//         builder: (context, state) => const AddInsightForm(),
//       ),
//       // GoRoute(
//       //   path: UpdateInsight.route,
//       //   name: '',
//       //   builder: (context, state) {
//       //     final args = state.extra as Map<String, dynamic>?;
//       //     return UpdateInsight(
//       //       insightId: args?['insightId'] ?? '',
//       //       initialData: args?['initialData'],
//       //     );
//       //   },
//       // ),
//     ],
//
//     // Redirect logic (example - customize based on your auth needs)
//     redirect: (BuildContext context, GoRouterState state) {
//       final isLoggedIn = false; // Replace with your auth logic
//       final isAdminRoute = state.matchedLocation.startsWith('/AdminMainScreen');
//
//       if (isAdminRoute && !isLoggedIn) {
//         return LoginScreen.route;
//       }
//
//       return null;
//     },
//
//
//     // Error page
//   errorBuilder: (context, state) => Scaffold(
//     body: Center(
//         child: Text('Page not found: ${state.uri}'),
//     ),
//   ),
// );