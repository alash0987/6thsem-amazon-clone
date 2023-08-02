import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/home/services/home_services.dart';
import 'package:amazonclone/models/product_model.dart';
import 'package:amazonclone/provider/product_provider.dart';
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
  // List<Product> productList = [];
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   fetchCategoryProducts();
  // }

  // fetchCategoryProducts() async {
  //   productList = await HomeServices()
  //       .fetchCategoryProducts(context: context, category: widget.category);
  //   setState(() {});
  // }

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
          ? const Center(
              child: CircularProgressIndicator(),
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
                        return Column(
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
                            )
                          ],
                        );
                      }),
                )
              ],
            ),
    );
  }
}
