import 'package:amazonclone/constants/button_bar.dart';
import 'package:amazonclone/features/address/screens/address_screen.dart';
import 'package:amazonclone/features/admin/screens/add_product_screen.dart';
import 'package:amazonclone/features/admin/screens/admin_screen.dart';
import 'package:amazonclone/features/auth/screen/auth_screen.dart';
import 'package:amazonclone/features/cart/screens/cart_screen.dart';
import 'package:amazonclone/features/home/screen/category_deal_screen.dart';
import 'package:amazonclone/features/home/screen/home_screen.dart';
import 'package:amazonclone/features/order_details/screens/order_details_screen.dart';
import 'package:amazonclone/features/product_details/screen/product_details_screen.dart';
import 'package:amazonclone/features/search/screens/search_screen.dart';
import 'package:amazonclone/features/splashscreen/splash_screen.dart';
import 'package:amazonclone/models/order.dart';
import 'package:amazonclone/models/product_model.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AuthScreen(),
      );
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => AddressScreen(
          totalAmount: totalAmount,
        ),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => HomeScreen());
    case ButtomBar.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => ButtomBar());
    case CartScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => CartScreen());
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
    case SearchScreen.routeName:
      var search = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: search,
        ),
      );
    case OrderDetailScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OrderDetailScreen(
          order: order,
        ),
      );
    case CategoryDealScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => CategoryDealScreen(
          category: category,
        ),
      );
    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ProductDetailsScreen(
          product: product,
        ),
      );

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${routeSettings.name}'),
          ),
        ),
      );
  }
}
