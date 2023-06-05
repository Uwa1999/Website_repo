import 'package:flutter/material.dart';
import 'package:layout/layout.dart';
import 'package:FDS_ASYA_PHILIPPINES/presentation/routes/router.gr.dart';
import 'package:FDS_ASYA_PHILIPPINES/values/values.dart';

import 'app_theme.dart';

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
