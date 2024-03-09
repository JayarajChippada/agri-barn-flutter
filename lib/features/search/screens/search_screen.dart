// ignore_for_file: use_build_context_synchronously

import 'package:appathon/common/loader.dart';
import 'package:appathon/constants/utils.dart';
import 'package:appathon/features/product_details/screens/product_details_screen.dart';
import 'package:appathon/features/search/services/search_services.dart';
import 'package:appathon/features/search/widgets/searched_product.dart';
import 'package:appathon/models/product_model.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({super.key, required this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final SearchServices searchServices = SearchServices();
  @override
  void initState() {
    super.initState();
    fetchSearchedProduct();
  }

  void navigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQuery);
  }

  void fetchSearchedProduct() async {
    try {
      products = await searchServices.fetchSearchedProduct(
          context: context, searchQuery: widget.searchQuery);
      print(products);
      setState(() {});
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void navigateToProductDetailsScreen(Product product) {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                ),
                title:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        height: 42,
                        margin: const EdgeInsets.only(left: 15),
                        child: Material(
                          borderRadius: BorderRadius.circular(7),
                          elevation: 1,
                          child: TextFormField(
                            onFieldSubmitted: navigateToSearchScreen,
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
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7)),
                                  borderSide: BorderSide(
                                      color: Colors.black38, width: 1),
                                ),
                                hintText: 'Search AgriBarn',
                                hintStyle: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w500)),
                          ),
                        ),
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
                    ),
                  ],
                ),
              ),
            ),
            body: products == null
          ? const Loader()
          :  Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                products == null
                    ? const Loader()
                    : Expanded(
                        child: ListView.builder(
                          itemCount: products!.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () => navigateToProductDetailsScreen(
                                    products![index]),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: SearchedProduct(
                                      product: products![index]),
                                ));
                          },
                        ),
                      ),
              ],
            ),
          );
  }
}
