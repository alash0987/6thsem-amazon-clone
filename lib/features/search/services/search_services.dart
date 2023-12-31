// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'package:amazonclone/constants/error_handling.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/constants/utils.dart';
import 'package:amazonclone/features/search/provider/search_product_provider.dart';
import 'package:amazonclone/models/product_model.dart';
import 'package:amazonclone/provider/user_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<Product>> fetchSearchProduct({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final searchProvider =
        Provider.of<SearchProductProvider>(context, listen: false);

    List<Product> productList = [];
    try {
      http.Response response = await http
          .get(Uri.parse('$uri/api/products/search/$searchQuery'), headers: {
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
    searchProvider.searchProductSet = productList;
    if (kDebugMode) {
      print(
        '============${searchProvider.searchProduct.length}===================');
    }
    return productList;
  }
}
