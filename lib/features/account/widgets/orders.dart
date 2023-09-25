// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/account/widgets/single_product.dart';
import 'package:amazonclone/features/order_details/screens/order_details_screen.dart';
import 'package:amazonclone/models/order.dart';
import 'package:amazonclone/provider/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Orders extends StatelessWidget {
  Orders({super.key});

  List<Order>? orders;

  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<OrderProvider>(context, listen: false).orders;
    return orders == null
        ? const CircularProgressIndicator()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: const Text(
                      'Your Orders',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      right: 15,
                    ),
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: GlobalVariable.selectedNavBarColor,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 170,
                padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, OrderDetailScreen.routeName,
                            arguments: orders[index]);
                      },
                      child: SingleProduct(
                        image: orders[index].products[0].images[0].toString(),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
