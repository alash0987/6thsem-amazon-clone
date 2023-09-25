// ignore_for_file: use_build_context_synchronously, must_be_immutable

import 'package:amazonclone/common/widgets/stars.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/constants/utils.dart';
import 'package:amazonclone/features/cart/screens/cart_screen.dart';
import 'package:amazonclone/features/home/provider/deal_of_day_provider.dart';
import 'package:amazonclone/features/home/services/home_services.dart';
import 'package:amazonclone/features/product_details/provider/rating_provider.dart';
import 'package:amazonclone/features/product_details/screen/product_details_screen.dart';
import 'package:amazonclone/features/product_details/services/product_details_services.dart';
import 'package:amazonclone/models/product_model.dart';
import 'package:amazonclone/provider/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class DealOfDay extends StatelessWidget {
  DealOfDay({super.key});
  HomeServices homeServices = HomeServices();

  @override
  Widget build(BuildContext context) {
    ProductDetailsServices productDetailsServices = ProductDetailsServices();
    homeServices.fetchDealOfDay(context: context);
    var dealOfDavProvider = Provider.of<DealOfDayProvider>(context);
    return dealOfDavProvider.dealOfDay == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : dealOfDavProvider.dealOfDay!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: () async {
                  //  I want to update the rating here as well
                  await updateRatings(context, dealOfDavProvider.dealOfDay!);
                  Navigator.pushNamed(context, ProductDetailsScreen.routeName,
                      arguments: dealOfDavProvider.dealOfDay);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: Text(
                        'Deal of the Day',
                        style: TextStyle(
                          color: appPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
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
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Image.network(
                                dealOfDavProvider.dealOfDay!.images[0],
                                fit: BoxFit.fill,
                                height: 150,
                                width: 200,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              dealOfDavProvider.dealOfDay!.name,
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              dealOfDavProvider.dealOfDay!.description,
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
                                rating: dealOfDavProvider
                                    .dealOfDay!.rating![0].rating
                                    .toDouble()),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Rs. ${dealOfDavProvider.dealOfDay!.price}',
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 208, 145, 9)),
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
                                      context,
                                      CartScreen.routeName,
                                      arguments: dealOfDavProvider
                                          .dealOfDay!.price
                                          .toString(),
                                    );
                                    productDetailsServices.addToCart(
                                        context: context,
                                        product: dealOfDavProvider.dealOfDay!);
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
                    )

                    //
                    // Image.network(dealOfDavProvider.dealOfDay!.images[0],
                    //     fit: BoxFit.cover, height: 235),
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   padding: const EdgeInsets.only(left: 15, top: 5),
                    //   child: const Text('\$100',
                    //       style: TextStyle(
                    //         fontSize: 18,
                    //       )),
                    // ),
                    // Container(
                    //   alignment: Alignment.topLeft,
                    //   padding:
                    //       const EdgeInsets.only(left: 15, top: 5, right: 40),
                    //   child: const Text(
                    //     'Alash',
                    //     maxLines: 2,
                    //     overflow: TextOverflow.ellipsis,
                    //   ),
                    // ),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: dealOfDavProvider.dealOfDay!.images
                    //         .map((e) => Image.network(e,
                    //             fit: BoxFit.fitHeight, height: 100))
                    //         .toList(),
                    //   ),
                    // ),
                    // Container(
                    //   padding: const EdgeInsets.symmetric(
                    //     vertical: 15,
                    //   ).copyWith(left: 15),
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     'See all deals',
                    //     style: TextStyle(
                    //       color: Colors.cyan[800],
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              );
  }
}

// void fetchDealOfDay(BuildContext context) {
//   HomeServices homeServices = HomeServices();
//   homeServices.fetchDealOfDay(context: context);
// }
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
