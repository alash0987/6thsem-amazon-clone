// ignore_for_file: use_build_context_synchronously, prefer_final_fields

import 'package:amazonclone/constants/global_variable.dart';
import 'package:amazonclone/features/auth/services/auth_service.dart';
import 'package:amazonclone/features/home/widgets/address_box.dart';
import 'package:amazonclone/features/home/widgets/carousell_image.dart';
import 'package:amazonclone/features/home/widgets/deal_of_day.dart';
import 'package:amazonclone/features/home/widgets/top_categories.dart';
import 'package:amazonclone/features/search/screens/search_screen.dart';
import 'package:amazonclone/features/search/services/search_services.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  static const routeName = '/home_screen';
  HomeScreen({
    super.key,
  });

  AuthService authService = AuthService();
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariable.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 10),
                  child: Material(
                      borderRadius: BorderRadius.circular(7),
                      elevation: 1,
                      child: TextFormField(
                        controller: _searchController,
                        onFieldSubmitted: (value) {
                          // await updateRating(context, products);
                          navigateToSearchScreen(context, value);
                        },
                        decoration: InputDecoration(
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(left: 6),
                              child: Icon(
                                Icons.search,
                                color: Colors.black,
                                size: 23,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              borderSide:
                                  BorderSide(color: Colors.black38, width: 1)),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(7)),
                          ),
                          hintText: 'Search Amazon.in',
                          hintStyle: const TextStyle(
                              color: Colors.black38,
                              fontSize: 17,
                              fontWeight: FontWeight.w500),
                        ),
                      )),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(
                  Icons.mic,
                  color: Colors.black,
                  size: 25,
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            const SizedBox(
              height: 10,
            ),
            const TopCategories(),
            const SizedBox(
              height: 10,
            ),
            const CarouselImage(),
            const SizedBox(
              height: 10,
            ),
            DealOfDay(),
          ],
        ),
      ),
    );
  }
}

navigateToSearchScreen(BuildContext context, String query) async {
  await fetchSearchProduct(context, query);
  Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
}

fetchSearchProduct(BuildContext context, String query) async {
  final SearchServices searchServices = SearchServices();
  await searchServices.fetchSearchProduct(context: context, searchQuery: query);
}
