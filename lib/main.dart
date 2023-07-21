import 'package:FDS_ASYA_PHILIPPINES/ui/screens/homepage/homepage_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:layout/layout.dart';

void main() {
  runApp(Fdsap());
}

class Fdsap extends StatelessWidget {
  // final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FDS ASYA PHILIPPINES INC.',
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(
            bodyColor: Colors.black54,
          ),
        ),
        home: HomepageScreen(),
      ),

      // child: MaterialApp.router(
      //   title: StringConst.APP_NAME,
      //   theme: AppTheme.lightThemeData,
      //   debugShowCheckedModeBanner: false,
      //   routerDelegate: _appRouter.delegate(),
      //   routeInformationParser: _appRouter.defaultRouteParser(),
      // ),
    );
  }
}
