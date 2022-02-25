import 'package:dads_app/pages/activities.page.dart';
import 'package:dads_app/pages/base.page.dart';
import 'package:dads_app/pages/login.page.dart';
import 'package:flutter/material.dart';
import 'package:dads_app/pages/album.page.dart';

// Main app that handles all the routes and pages
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: BasePage.routeName,
      routes: {
        BasePage.routeName: (_) => const BasePage(),
        AlbumPage.routeName: (_) => const AlbumPage(),
        ActivitiesPage.routeName: (_) => const ActivitiesPage(),
        LoginPage.routeName: (_) => LoginPage(),
      },
    );
  }
}
