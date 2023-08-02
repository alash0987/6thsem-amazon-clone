// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:amazonclone/provider/product_provider.dart';
import 'package:amazonclone/features/admin/screens/admin_screen.dart';
import 'package:amazonclone/features/admin/services/admin_services.dart';
import 'package:amazonclone/features/auth/screen/auth_screen.dart';
import 'package:amazonclone/features/auth/services/auth_service.dart';
import 'package:amazonclone/features/home/screen/home_screen.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashServices {
  AdminServices adminServices = AdminServices();
  AuthService authService = AuthService();
  isLogin(BuildContext context) async {
    await authService.getUserData(context);

    var user = Provider.of<UserProvider>(context, listen: false).user;
    var setProduct = Provider.of<ProductProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String isLogin = prefs.getString('x-auth-token') ?? '';
    if (isLogin.isNotEmpty && user.type == 'admin') {
      setProduct.productsSet = await adminServices.fetchAllProducts(context);
      Timer(const Duration(seconds: 3),
          () => Navigator.pushReplacementNamed(context, AdminScreen.routeName));
    } else if (isLogin.isNotEmpty && user.type == 'user') {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      });
    } else {
      Timer(const Duration(seconds: 3),
          () => Navigator.pushReplacementNamed(context, AuthScreen.routeName));
    }
  }
}
