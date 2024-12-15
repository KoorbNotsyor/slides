import 'package:flutter/material.dart';
import 'package:slides/ui/app/theme.dart';
import 'package:slides/control/app_state.dart';
import 'package:slides/control/log_navigation.dart';
import 'package:slides/control/routes.dart';
import 'package:slides/control/service_locator.dart';
import 'package:slides/ui/page/setup/setup.dart';


class Slides extends StatelessWidget {
  Slides({super.key});

  final appState = getIt.get<AppState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [LogNavigation()],
      title: 'Slides',
      //initialRoute: '/',
      onGenerateRoute: Routes.generateRoute,
      theme: appTheme,
      home: Setup(),
    );
  }
}
