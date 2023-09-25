// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'package:amazonclone/constants/error_handling.dart';
import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/constants/utils.dart';
import 'package:amazonclone/features/admin/model/sales_model.dart';
import 'package:amazonclone/features/admin/provider/order_provider.dart';
import 'package:amazonclone/features/splashscreen/splash_screen.dart';
import 'package:amazonclone/models/order.dart';
import 'package:amazonclone/models/product_model.dart';
import 'package:amazonclone/provider/user_provider.dart';
// import 'package:cloudinary/cloudinary.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  Future sellProduct({
    required BuildContext context,
    required String name,
    required double price,
    required String description,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      List<String> urls = [];

      for (var i = 0; i < images.length; i++) {
        File file = File(images[i].path);

        try {
          var cloudinary = CloudinaryPublic(
              GlobalVariable.cloudinaryName, GlobalVariable.uploadPreset,
              cache: false);
          CloudinaryResponse response = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(file.path,
                resourceType: CloudinaryResourceType.Image, folder: name),
          );
          urls.add(response.secureUrl);
          debugPrint(response.secureUrl);
        } on CloudinaryException catch (e) {
          debugPrint(e.message);
          debugPrint(e.request.toString());
        }
      }

      Product product = Product(
          name: name,
          price: price,
          description: description,
          quantity: quantity,
          category: category,
          images: urls);
      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(
                context: context, message: 'Product added successfully');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackbar(context: context, message: e.toString());
    }
  }

  //  get all products
  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response response =
          await http.get(Uri.parse('$uri/admin/get-products'), headers: {
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
    return productList;
  }

  //  delete product
  void deleteProduct({
    required BuildContext context,
    required Product product,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackbar(
                context: context, message: 'Product Deleted  successfully');
            // Navigator.pop(context);
            Navigator.popAndPushNamed(context, SplashScreen.routeName);
          });
    } catch (e) {
      showSnackbar(context: context, message: e.toString());
    }
  }

  //  get all products
  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final orderProviderAdmin =
        Provider.of<OrderProviderAdmin>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            orderList.add(
              Order.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      // showSnackBar(context, e.toString());
      showSnackbar(context: context, message: e.toString());
    }
    orderProviderAdmin.ordersSet = orderList;
    return orderList;
  }

  //  status changing
  void changeOrderStatus({
    required BuildContext context,
    required int status,
    required Order order,
    required VoidCallback onSuccess,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/change-order-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: onSuccess,
      );
    } catch (e) {
      // showSnackBar(context, e.toString());
      showSnackbar(context: context, message: e.toString());
    }
  }

  //  get status of order
  Future<String> getStatus() async {
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-current-order-status'));
      if (res.statusCode == 200) {
        return res.body;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return '0';
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/analytics'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales('Mobiles', response['mobileEarnings']),
            Sales('Essentials', response['essentialEarnings']),
            Sales('Books', response['booksEarnings']),
            Sales('Appliances', response['applianceEarnings']),
            Sales('Fashion', response['fashionEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackbar(context: context, message: e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings': totalEarning,
    };
  }
}
