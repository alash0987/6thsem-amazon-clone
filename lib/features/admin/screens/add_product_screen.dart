// ignore_for_file: use_build_context_synchronously

import 'package:amazonclone/common/widgets/custom_button.dart';
import 'package:amazonclone/common/widgets/custom_textfield.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/admin/services/admin_services.dart';
import 'package:amazonclone/provider/dropdown_provider.dart';
import 'package:amazonclone/provider/pick-Image_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatelessWidget {
  static const routeName = '/add-product-screen';
  AddProductScreen({super.key});
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();
  final TextEditingController _productDescriptionController =
      TextEditingController();
  final TextEditingController _productQuantityController =
      TextEditingController();
  final _addProductFormKey = GlobalKey<FormState>();
  final AdminServices _adminServices = AdminServices();
  sellProduct(BuildContext context) async {
    if (_addProductFormKey.currentState!.validate() ||
        Provider.of<PickImageProvider>(context, listen: false)
            .images
            .isNotEmpty) {
      await _adminServices.sellProduct(
          context: context,
          name: _productNameController.text,
          price: double.parse(_productPriceController.text),
          description: _productDescriptionController.text,
          quantity: double.parse(_productQuantityController.text),
          category: Provider.of<DropdownProvider>(context, listen: false)
              .selectedCategory,
          images:
              Provider.of<PickImageProvider>(context, listen: false).images);
    }
  }

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
            title: const Text(
              'Add Product',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _addProductFormKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Consumer<PickImageProvider>(
                    builder: (context, imagePickProvider, child) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      imagePickProvider.images.isNotEmpty
                          ? CarouselSlider(
                              items: imagePickProvider.images
                                  .map((i) => Builder(
                                      builder: (BuildContext context) =>
                                          Image.file(
                                            i,
                                            fit: BoxFit.cover,
                                            height: 200,
                                          )))
                                  .toList(),
                              options: CarouselOptions(
                                viewportFraction: 1,
                                height: 200,
                                autoPlay: true,
                              ))
                          : InkWell(
                              onTap: imagePickProvider.selectImages,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: DottedBorder(
                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(10),
                                  dashPattern: const [10, 4],
                                  strokeCap: StrokeCap.round,
                                  child: Container(
                                    width: double.infinity,
                                    height: 150,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.folder_open_outlined,
                                          size: 40,
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          'Add Product Image',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomTextField(
                          title: 'Product Name',
                          controller: _productNameController,
                          hintText: 'Product Name'),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          maxline: 7,
                          title: 'Description',
                          controller: _productDescriptionController,
                          hintText: 'Description'),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          title: 'Price',
                          controller: _productPriceController,
                          hintText: 'Price'),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          title: 'Quantity',
                          controller: _productQuantityController,
                          hintText: 'Quantity'),
                      const SizedBox(
                        height: 20,
                      ),
                      Consumer<DropdownProvider>(
                          builder: (context, dropprovider, child) {
                        return SizedBox(
                          child: DropdownButton(
                              value: dropprovider.selectedCategory,
                              items: dropprovider.productCatagories
                                  .map((value) => DropdownMenuItem(
                                        value: value,
                                        child: Text(value),
                                      ))
                                  .toList(),
                              icon: const Icon(Icons.keyboard_arrow_down),
                              onChanged: (String? newvalue) {
                                dropprovider.changeSelectedCategory(newvalue!);
                              }),
                        );
                      }),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          text: 'Sell',
                          onPressed: () async {
                            debugPrint('Sell Product');
                            await sellProduct(context);
                            debugPrint('Sell Product 2');
                          }),
                    ],
                  );
                }),
              )),
        ));
  }
}
