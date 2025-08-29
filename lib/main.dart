import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:layout/layout.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app_route.dart';
import 'core/provider/article_provider.dart';
import 'core/provider/user_provider.dart';
import 'ui/screens/admin/not_found/page_not_found.dart';
import 'ui/screens/admin/auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy(); // Clean URLs

  // ✅ Initialize articleProvider and load from SharedPreferences
  final articleProvider = ArticleProvider();
  await articleProvider.loadFromPrefs();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider<ArticleProvider>.value(
          value: articleProvider,
        ),
      ],
      child: const Fdsap(),
    ),
  );
}

class Fdsap extends StatelessWidget {
  const Fdsap({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp(
        title: 'FDS ASYA PHILIPPINES INC.',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ).apply(bodyColor: Colors.black54),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: LoginScreen.route,
        routes: appRoutes,
        onUnknownRoute: (_) => MaterialPageRoute(
          builder: (_) => const NotFoundScreen(),
        ),
      ),
    );
  }
}
