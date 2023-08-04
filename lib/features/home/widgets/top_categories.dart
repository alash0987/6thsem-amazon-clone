// ignore_for_file: use_build_context_synchronously

import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/home/screen/category_deal_screen.dart';
import 'package:amazonclone/features/home/services/home_services.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  const TopCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemExtent: 75,
        itemCount: GlobalVariable.categoryImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => navigateToCategoryDealScreen(
                context, GlobalVariable.categoryImages[index]['title']!),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      GlobalVariable.categoryImages[index]['image']!,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  GlobalVariable.categoryImages[index]['title']!,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

navigateToCategoryDealScreen(BuildContext context, String category) async {
  // Provider.of<ProductProvider>(context, listen: false).categoryProducts;
  await HomeServices()
      .fetchCategoryProducts(context: context, category: category);
  Navigator.pushNamed(context, CategoryDealScreen.routeName,
      arguments: category);
}
