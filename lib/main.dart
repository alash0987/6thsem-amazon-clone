import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/admin/provider/product_provider.dart';
import 'package:amazonclone/features/auth/provider/login_signup_provider.dart';
import 'package:amazonclone/features/auth/services/auth_service.dart';
import 'package:amazonclone/features/splashscreen/splash_screen.dart';
import 'package:amazonclone/provider/buttom_bar_provider.dart';
import 'package:amazonclone/provider/dropdown_provider.dart';
import 'package:amazonclone/provider/pick-Image_provider.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:amazonclone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<LoginSignupProvider>(
          create: (_) => LoginSignupProvider()),
      ChangeNotifierProvider<ButtomBarProvider>(
          create: (_) => ButtomBarProvider()),
      ChangeNotifierProvider<DropdownProvider>(
          create: (_) => DropdownProvider()),
      ChangeNotifierProvider<PickImageProvider>(
        create: (_) => PickImageProvider(),
      ),
      ChangeNotifierProvider<ProductProvider>(
        create: (_) => ProductProvider(),
      )
    ],
    child: MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => UserProvider())],
      child: MainApp(),
    ),
  ));
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amzon Clone',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: GlobalVariable.secondaryColor,
        ),
        scaffoldBackgroundColor: GlobalVariable.backgroundColor,
        appBarTheme: const AppBarTheme(
            elevation: 0.0, iconTheme: IconThemeData(color: Colors.black)),
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: ((settings) => generateRoute(settings)),
      home: const SplashScreen(),
    );
  }
}