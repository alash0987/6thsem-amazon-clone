// ignore_for_file: must_be_immutable

import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/account/screens/account_screen.dart';
import 'package:amazonclone/features/cart/screens/cart_screen.dart';
import 'package:amazonclone/features/home/screen/home_screen.dart';
import 'package:amazonclone/provider/buttom_bar_provider.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtomBar extends StatelessWidget {
  static const routeName = '/actual_home';
  ButtomBar({super.key});
  double bottomNavBarWidth = 42;
  double bottomBarBorderWidth = 5;
  List<Widget> screen = [HomeScreen(), const AccountScreen(), CartScreen()];
  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart.length;
    return Consumer<ButtomBarProvider>(
        builder: (context, buttomProvider, child) {
      return Scaffold(
        body: screen.elementAt(buttomProvider.currentIndex),
        bottomNavigationBar: BottomNavigationBar(
          onTap: buttomProvider.changeIndex,
          currentIndex: buttomProvider.currentIndex,
          selectedItemColor: GlobalVariable.selectedNavBarColor,
          unselectedItemColor: GlobalVariable.unselectedNavBarColor,
          backgroundColor: GlobalVariable.backgroundColor,
          iconSize: 28,
          items: [
            //  home page
            BottomNavigationBarItem(
              icon: Container(
                width: bottomNavBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: buttomProvider.currentIndex == 0
                                ? GlobalVariable.selectedNavBarColor
                                : GlobalVariable.backgroundColor,
                            width: bottomBarBorderWidth))),
                child: const Icon(Icons.home_outlined),
              ),
              label: '',
            ),
            //  account
            BottomNavigationBarItem(
              icon: Container(
                width: bottomNavBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: buttomProvider.currentIndex == 1
                                ? GlobalVariable.selectedNavBarColor
                                : GlobalVariable.backgroundColor,
                            width: bottomBarBorderWidth))),
                child: const Icon(Icons.person_outline_outlined),
              ),
              label: '',
            ),
            //  cart
            BottomNavigationBarItem(
              icon: Container(
                  width: bottomNavBarWidth,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: buttomProvider.currentIndex == 2
                                  ? GlobalVariable.selectedNavBarColor
                                  : GlobalVariable.backgroundColor,
                              width: bottomBarBorderWidth))),
                  child: Stack(
                    children: [
                      const Icon(Icons.shopping_cart_outlined),
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            userCartLength.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    ],
                  )),
              label: '',
            ),
          ],
        ),
      );
    });
  }
}
