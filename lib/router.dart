import 'package:amazonclone/constants/button_bar.dart';
import 'package:amazonclone/features/admin/screens/add_product_screen.dart';
import 'package:amazonclone/features/admin/screens/admin_screen.dart';
import 'package:amazonclone/features/auth/screen/auth_screen.dart';
import 'package:amazonclone/features/home/screen/category_deal_screen.dart';
import 'package:amazonclone/features/home/screen/home_screen.dart';
import 'package:amazonclone/features/splashscreen/splash_screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => AuthScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => HomeScreen());
    case ButtomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => ButtomBar());
    case AdminScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => AdminScreen());
    case AddProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => AddProductScreen());
    case SplashScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const SplashScreen(),
      );
    case CategoryDealScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealScreen(
          category: category,
        ),
      );

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${routeSettings.name}'),
                ),
              ));
  }
}
