// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazonclone/constants/error_handling.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/constants/utils.dart';
import 'package:amazonclone/features/home/provider/deal_of_day_provider.dart';
import 'package:amazonclone/models/product_model.dart';
import 'package:amazonclone/provider/product_provider.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    List<Product> productList = [];
    try {
      http.Response response = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(jsonDecode(response.body)[i]),
                ),
              );
            }
          });
    } catch (e) {
      showSnackbar(context: context, message: e.toString());
    }
    productProvider.categoryProductsSet = productList;
    return productList;
  }

  //
  Future<Product> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final productProvider =
        Provider.of<DealOfDayProvider>(context, listen: false);

    Product product = Product(
        name: '',
        price: 0,
        description: '',
        quantity: 0,
        category: '',
        images: []);
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandle(
          response: response,
          context: context,
          onSuccess: () {
            product = Product.fromJson(response.body);
          });
    } catch (e) {
      showSnackbar(context: context, message: e.toString());
    }
    // productProvider.categoryProductsSet = productList;
    productProvider.dealOfDaySet = product;

    return product;
  }
}
