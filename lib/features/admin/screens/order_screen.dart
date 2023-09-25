import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/account/widgets/single_product.dart';
import 'package:amazonclone/features/admin/services/admin_services.dart';
import 'package:amazonclone/features/order_details/screens/order_details_screen.dart';
import 'package:amazonclone/models/order.dart';
import 'package:flutter/material.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final AdminServices adminServices = AdminServices();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await adminServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Total Orders: ${orders!.length}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ).copyWith(color: appPrimaryColor),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  itemCount: orders!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final orderData = orders![index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          OrderDetailScreen.routeName,
                          arguments: orderData,
                        );
                      },
                      child: SizedBox(
                        height: 140,
                        child: SingleProduct(
                          image: orderData.products[0].images[0],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }
}
