import 'package:amazonclone/common/widgets/custom_button.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/address/screens/address_screen.dart';
import 'package:amazonclone/features/cart/screens/cart_product.dart';
import 'package:amazonclone/features/cart/widgets/cart_subtotal.dart';
import 'package:amazonclone/features/home/widgets/address_box.dart';
import 'package:amazonclone/features/search/screens/search_screen.dart';
import 'package:amazonclone/features/search/services/search_services.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart_screen';
  CartScreen({super.key});
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariable.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 10),
                  child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        controller: _searchController,
                        onFieldSubmitted: (value) {
                          // await updateRating(context, products);
                          navigateToSearchScreen(context, value);
                        },
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1)),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(
                              color: Colors.black38,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8),
              child: CustomButton(
                text: 'Proceed to buy ${user.cart.length} item',
                onPressed: () => navigateToAddress(context),
                color: Colors.yellow[600],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: user.cart.length,
                itemBuilder: (context, index) {
                  return CartProduct(index: index);
                })
          ],
        ),
      ),
    );
  }
}

navigateToSearchScreen(BuildContext context, String query) async {
  await fetchSearchProduct(context, query);
  Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
}

fetchSearchProduct(BuildContext context, String query) async {
  final SearchServices searchServices = SearchServices();
  await searchServices.fetchSearchProduct(context: context, searchQuery: query);
}

navigateToAddress(BuildContext context) {
  Navigator.pushNamed(context, AddressScreen.routeName);
}
