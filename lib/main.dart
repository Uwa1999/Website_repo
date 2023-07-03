import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/utils/router.gr.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/app_theme.dart';
import 'package:FDS_ASYA_PHILIPPINES/ui/screens/shared/values/strings.dart';
import 'package:flutter/material.dart';
import 'package:layout/layout.dart';

void main() {
  runApp(Fdsap());
}

class Fdsap extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp.router(
        title: StringConst.APP_NAME,
        theme: AppTheme.lightThemeData,
        debugShowCheckedModeBanner: false,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
