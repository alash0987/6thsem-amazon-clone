// ignore_for_file: unused_local_variable

import 'package:amazonclone/common/widgets/stars.dart';
import 'package:amazonclone/features/product_details/provider/rating_provider.dart';
import 'package:amazonclone/models/product_model.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchedProduct extends StatefulWidget {
  final Product product;
  const SearchedProduct({super.key, required this.product});

  @override
  State<SearchedProduct> createState() => _SearchedProductState();
}

class _SearchedProductState extends State<SearchedProduct> {
  updateRating(BuildContext context) {
    var ratingProvider = Provider.of<RatingProvider>(context, listen: false);
    var myRating = ratingProvider.myRating;
    var avgRating = ratingProvider.avgRating;
    var totalRating = ratingProvider.totalRating;
    for (int i = 0; i < widget.product.rating!.length; i++) {
      totalRating += widget.product.rating![i].rating;
      if (widget.product.rating![i].userId ==
          Provider.of<UserProvider>(context, listen: false).user.id) {
        myRating = widget.product.rating![i].rating;
        // ratingProvider.updateMyRating(myRating);
      }
    }
    if (totalRating != 0) {
      avgRating = totalRating / widget.product.rating!.length;
      ratingProvider.updateAvgRating(avgRating);
    }
  }

  @override
  void initState() {
    super.initState();
    updateRating(context);
  }

  @override
  Widget build(BuildContext context) {
    // updateRating(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: Row(
            children: [
              Image.network(widget.product.images[0],
                  fit: BoxFit.contain, height: 135, width: 135),
              Column(
                children: [
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Stars(
                        rating:
                            Provider.of<RatingProvider>(context, listen: false)
                                .avgRating),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Text(
                      '\$${widget.product.price}',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  // Text('${product.category}'),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10),
                    child: const Text(
                      'Eligible for Free Shipping',
                    ),
                  ),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: const Text(
                      'In Stock',
                      maxLines: 2,
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
