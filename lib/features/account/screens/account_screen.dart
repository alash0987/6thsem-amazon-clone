import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/account/widgets/below_app_bar.dart';
import 'package:amazonclone/features/account/widgets/orders.dart';
import 'package:amazonclone/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariable.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Container(
              //   alignment: Alignment.topLeft,
              //   child: Image.asset(
              //     'assets/images/college_logo.png',
              //     width: 150,
              //     height: 45,
              //     // color: Colors.black,
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const BelowAppBar(),
          const SizedBox(
            height: 10,
          ),
          const TopButtons(),
          const SizedBox(
            height: 20,
          ),
          Orders()
        ],
      ),
    );
  }
}
