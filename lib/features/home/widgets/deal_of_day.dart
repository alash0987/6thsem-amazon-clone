// ignore_for_file: use_build_context_synchronously

import 'package:amazonclone/features/home/provider/deal_of_day_provider.dart';
import 'package:amazonclone/features/home/services/home_services.dart';
import 'package:amazonclone/features/product_details/provider/rating_provider.dart';
import 'package:amazonclone/features/product_details/screen/product_details_screen.dart';
import 'package:amazonclone/models/product_model.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DealOfDay extends StatelessWidget {
  DealOfDay({super.key});
  HomeServices homeServices = HomeServices();

  @override
  Widget build(BuildContext context) {
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
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        'Deal of the Day',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Image.network(dealOfDavProvider.dealOfDay!.images[0],
                        fit: BoxFit.cover, height: 235),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.only(left: 15, top: 5),
                      child: const Text('\$100',
                          style: TextStyle(
                            fontSize: 18,
                          )),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          const EdgeInsets.only(left: 15, top: 5, right: 40),
                      child: const Text(
                        'Alash',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: dealOfDavProvider.dealOfDay!.images
                            .map((e) => Image.network(e,
                                fit: BoxFit.fitHeight, height: 100))
                            .toList(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                      ).copyWith(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'See all deals',
                        style: TextStyle(
                          color: Colors.cyan[800],
                        ),
                      ),
                    )
                  ],
                ));
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
