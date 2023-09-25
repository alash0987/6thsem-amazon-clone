import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/admin/screens/analytics_screen.dart';
import 'package:amazonclone/features/admin/screens/order_screen.dart';
import 'package:amazonclone/features/admin/screens/post_screen.dart';
import 'package:amazonclone/provider/buttom_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class AdminScreen extends StatelessWidget {
  static const routeName = '/admin_screen';
  AdminScreen({super.key});
  double bottomNavBarWidth = 42;
  double bottomBarBorderWidth = 5;
  List<Widget> screen = [
    const PostScreen(),
    const AnalyticsScreen(),
    const OrdersScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ButtomBarProvider>(
        builder: (context, buttomProvider, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration:
                  const BoxDecoration(gradient: GlobalVariable.appBarGradient),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'Alash.com.np',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Text(
                  'Admin',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: buttomProvider.changeIndexAdmin,
          currentIndex: buttomProvider.currentIndexAdmin,
          selectedItemColor: GlobalVariable.selectedNavBarColor,
          unselectedItemColor: GlobalVariable.unselectedNavBarColor,
          backgroundColor: GlobalVariable.backgroundColor,
          iconSize: 28,
          items: [
            //  Post page
            BottomNavigationBarItem(
              icon: Container(
                width: bottomNavBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: buttomProvider.currentIndexAdmin == 0
                                ? GlobalVariable.selectedNavBarColor
                                : GlobalVariable.backgroundColor,
                            width: bottomBarBorderWidth))),
                child: const Icon(Icons.home_outlined),
              ),
              label: '',
            ),
            //  Analytics
            BottomNavigationBarItem(
              icon: Container(
                width: bottomNavBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: buttomProvider.currentIndexAdmin == 1
                                ? GlobalVariable.selectedNavBarColor
                                : GlobalVariable.backgroundColor,
                            width: bottomBarBorderWidth))),
                child: const Icon(Icons.analytics_outlined),
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
                              color: buttomProvider.currentIndexAdmin == 2
                                  ? GlobalVariable.selectedNavBarColor
                                  : GlobalVariable.backgroundColor,
                              width: bottomBarBorderWidth))),
                  child: const Icon(Icons.all_inbox_outlined)),
              label: '',
            ),
          ],
        ),
        body: screen.elementAt(buttomProvider.currentIndexAdmin),
      );
    });
  }
}
