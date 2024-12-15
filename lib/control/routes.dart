import 'package:flutter/material.dart';
import '../ui/page/front/front.dart';
import '../ui/page/about/about.dart';
import '../ui/page/settings/settings_form.dart';

class Routes {
  static Route<MaterialPageRoute> generateRoute(RouteSettings settings) {
    // Get the arguments passed to the route, if any
    final args = settings.arguments;

    //print('>>> ROUTE: generateRoute(${settings.name})...');

    switch (settings.name) {
//      case '/':
//        return MaterialPageRoute(
//          settings: settings,
//          builder: (_) => Front()
//          );
      case '/about':
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => About()
        );
      case '/settings':
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => SettingsForm()
        );
      case '/front':
        return MaterialPageRoute(
            settings: settings,
            builder: (_) => Front()
        );

//      case '/preferences':
//        return MaterialPageRoute(builder: (_) => PreferencesPage());


      default:
        // could return null and let others handle unknown route...
        // Perhaps recover to home page???
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Column(
              children:<Widget>[
                Text('ROUTE [$settings.name] not found'),
                ElevatedButton(
                  child: Text("Go home"),
                  onPressed: () {
                      Navigator.pushNamed(context, '/');
                    }
                  ),
              ],
              ),
            ),
          ),
        );
    }
  }
}
