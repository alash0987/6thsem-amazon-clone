// ignore_for_file: must_be_immutable, unused_local_variable, use_build_context_synchronously

import 'package:amazonclone/common/widgets/custom_button.dart';
import 'package:amazonclone/common/widgets/stars.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/product_details/provider/rating_provider.dart';
import 'package:amazonclone/features/product_details/services/product_details_services.dart';
import 'package:amazonclone/features/search/provider/search_product_provider.dart';
import 'package:amazonclone/features/search/screens/search_screen.dart';
import 'package:amazonclone/features/search/services/search_services.dart';
import 'package:amazonclone/models/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const routeName = '/product_details_screen';
  final Product product;
  final TextEditingController _searchController = TextEditingController();
  ProductDetailsScreen({super.key, required this.product});
  ProductDetailsServices productDetailsServices = ProductDetailsServices();
  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(product.id.toString()),
                  Stars(
                      rating:
                          Provider.of<RatingProvider>(context, listen: false)
                              .avgRating),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Text(
                product.name,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
            CarouselSlider(
              items: product.images
                  .map((i) => Builder(
                      builder: (BuildContext context) => Image.network(
                            i,
                            fit: BoxFit.contain,
                            height: 200,
                          )))
                  .toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 300,
                autoPlay: true,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                  text: 'Deal price: ',
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: '\$${product.price}',
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(product.description),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(
                10,
              ),
              child: CustomButton(text: 'Buy Now', onPressed: () {}),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(
                10,
              ),
              child: CustomButton(
                  text: 'Add to Cart',
                  onPressed: () {},
                  color: const Color.fromRGBO(254, 216, 19, 1)),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'Rate the product',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            RatingBar.builder(
              initialRating:
                  Provider.of<RatingProvider>(context, listen: false).myRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 30,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: GlobalVariable.secondaryColor,
              ),
              onRatingUpdate: (rating) {
                productDetailsServices.rateProduct(
                  context: context,
                  product: product,
                  rating: rating,
                );
              },
            ),
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
  var searchProduct =
      Provider.of<SearchProductProvider>(context, listen: false).searchProduct;
  final SearchServices searchServices = SearchServices();
  searchProduct = await searchServices.fetchSearchProduct(
      context: context, searchQuery: query);
}
