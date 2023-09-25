import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/constants/utils.dart';
import 'package:amazonclone/features/account/widgets/single_product.dart';
import 'package:amazonclone/provider/product_provider.dart';
import 'package:amazonclone/features/admin/screens/add_product_screen.dart';
import 'package:amazonclone/features/admin/services/admin_services.dart';
import 'package:amazonclone/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      body: productProvider.products == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: productProvider.products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = productProvider.products![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(image: productData.images[0]),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            productData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            deleteProduct(context, productData, index);
                          },
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ],
                    )
                  ],
                );
              }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: appPrimaryColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, AddProductScreen.routeName);
        },
        tooltip: 'Add a product',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

void deleteProduct(BuildContext context, Product product, int index) {
  AdminServices adminServices = AdminServices();
  adminServices.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        showSnackbar(context: context, message: 'Product deleted successfully');
      });
}
