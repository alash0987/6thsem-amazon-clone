import 'package:amazonclone/common/widgets/stars.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/constants/utils.dart';
import 'package:amazonclone/features/cart/screens/cart_screen.dart';
import 'package:amazonclone/features/product_details/provider/rating_provider.dart';
import 'package:amazonclone/features/product_details/screen/product_details_screen.dart';
import 'package:amazonclone/features/product_details/services/product_details_services.dart';
import 'package:amazonclone/models/product_model.dart';
import 'package:amazonclone/provider/product_provider.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryDealScreen extends StatefulWidget {
  static const String routeName = '/category-deal-screen';
  const CategoryDealScreen({super.key, required this.category});
  final String category;

  @override
  State<CategoryDealScreen> createState() => _CategoryDealScreenState();
}

class _CategoryDealScreenState extends State<CategoryDealScreen> {
  @override
  Widget build(BuildContext context) {
    ProductDetailsServices productDetailsServices = ProductDetailsServices();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariable.appBarGradient),
          ),
          title: Text(
            widget.category,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Provider.of<ProductProvider>(context, listen: true)
              .categoryProducts
              .isEmpty
          ? Center(
              child: Text(Provider.of<ProductProvider>(context, listen: true)
                      .categoryProducts
                      .isEmpty
                  ? 'No products found'
                  : 'No products found for $widget.category'),
            )
          : Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'keep shopping for ${widget.category}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 290,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 15),
                      itemCount:
                          Provider.of<ProductProvider>(context, listen: false)
                              .categoryProducts
                              .length,
                      itemBuilder: (context, index) {
                        final product =
                            Provider.of<ProductProvider>(context, listen: false)
                                .categoryProducts[index];
                        //  context
                        // .watch<ProductProvider>()
                        // .categoryProducts[index];
                        return GestureDetector(
                            onTap: () async {
                              updateRatings(context, product);

                              await Navigator.pushNamed(
                                context,
                                ProductDetailsScreen.routeName,
                                arguments: product,
                              );
                            },
                            child: Container(
                              width: 200,
                              height: 265,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Image.network(
                                        product.images[0],
                                        fit: BoxFit.fill,
                                        height: 150,
                                        width: 200,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      product.name,
                                      style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      product.description,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Stars(
                                        rating: product.rating![0].rating
                                            .toDouble()),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Rs. ${product.price}',
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromARGB(
                                                  255, 208, 145, 9)),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            print('tapped');

                                            showSnackbar(
                                                context: context,
                                                message: 'Added to cart');
                                            Navigator.pushNamed(
                                                context, CartScreen.routeName,
                                                arguments:
                                                    product.price.toString());
                                            productDetailsServices.addToCart(
                                                context: context,
                                                product: product);
                                          },
                                          child: const Icon(
                                            Icons.shopping_cart_outlined,
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }),
                )
              ],
            ),
    );
  }
}

updateRatings(BuildContext context, Product product) {
  var ratingProvider = Provider.of<RatingProvider>(context, listen: false);
  var myRating = ratingProvider.myRating;
  var avgRating = ratingProvider.avgRating;
  var totalRating = ratingProvider.totalRating;
  for (int i = 0; i < product.rating!.length; i++) {
    totalRating += product.rating![i].rating;
    if (product.rating![i].userId ==
        Provider.of<UserProvider>(context, listen: false).user.id) {
      myRating = product.rating![i].rating;
      ratingProvider.updateMyRating(myRating);
    }
  }
  if (totalRating != 0) {
    avgRating = totalRating / product.rating!.length;
    ratingProvider.updateAvgRating(avgRating);
  }
}
