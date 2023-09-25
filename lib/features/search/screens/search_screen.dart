// ignore_for_file: unused_local_variable, use_build_context_synchronously

import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/home/widgets/address_box.dart';
import 'package:amazonclone/features/product_details/screen/product_details_screen.dart';
import 'package:amazonclone/features/search/provider/search_product_provider.dart';
import 'package:amazonclone/features/search/services/search_services.dart';
import 'package:amazonclone/features/search/widgets/searched_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();
  static const String routeName = '/search-screen';
  final String searchQuery;
  SearchScreen({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    var products = context.watch<SearchProductProvider>().searchProduct;
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
                          hintText: 'Search alash.com.np',
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
      body: products.isEmpty
          ? Center(
              child: Animate(
                effects: const [
                  ShakeEffect(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.bounceInOut,
                  ),
                  FlipEffect(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.bounceInOut,
                  ),
                  ScaleEffect(
                    duration: Duration(milliseconds: 1000),
                    curve: Curves.bounceInOut,
                  ),
                ],
                autoPlay: true,
                child: SizedBox(
                  height: 500,
                  width: 500,
                  child: Image.asset('assets/images/nproduct.png'),
                ),
              ),
            )
          : Column(
              children: [
                const AddressBox(),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, ProductDetailsScreen.routeName,
                                arguments: products[index]);
                          },
                          child: SearchedProduct(product: products[index]));
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

navigateToSearchScreen(BuildContext context, String query) async {
  await fetchSearchProduct(context, query);
  Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
}

fetchSearchProduct(BuildContext context, String query) async {
  var searchProduct =
      Provider.of<SearchProductProvider>(context, listen: false).searchProduct;
  final SearchServices searchServices = SearchServices();
  searchProduct = await searchServices.fetchSearchProduct(
      context: context, searchQuery: query);
}
