import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/product_details/provider/rating_provider.dart';
import 'package:amazonclone/features/product_details/screen/product_details_screen.dart';
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
                  height: 170,
                  child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.only(left: 15),
                      itemCount:
                          Provider.of<ProductProvider>(context, listen: false)
                              .categoryProducts
                              .length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1.5,
                        mainAxisSpacing: 10,
                      ),
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
                          child: Column(
                            children: [
                              SizedBox(
                                height: 130,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black, width: 0.5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(
                                      product.images[0],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(
                                    left: 0, top: 5, right: 15),
                                child: Text(product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                    )),
                              )
                            ],
                          ),
                        );
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
