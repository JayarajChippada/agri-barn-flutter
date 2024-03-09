import 'package:appathon/common/loader.dart';
import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/features/auth/services/auth_services.dart';
import 'package:appathon/features/home/services/home_services.dart';
import 'package:appathon/features/home/widgets/carousel_slider.dart';
import 'package:appathon/features/home/widgets/top_categories.dart';
import 'package:appathon/features/home/widgets/top_products.dart';
import 'package:appathon/features/product_details/screens/product_details_screen.dart';
import 'package:appathon/features/search/widgets/searched_product.dart';
import 'package:appathon/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic>? categories;
  HomeServices homeServices = HomeServices();
   AuthService authService = AuthService();
  List<Product>? products;


  @override
  void initState() {
    fetchCategories();
    fetchProducts();
    super.initState();
  }

  void fetchProducts() async {
    try {
      List<Product>? fetchedProducts =
          await authService.fetchAllProducts(context);
      print(fetchedProducts);
      setState(() {
        products = fetchedProducts;
      });
    } catch (e) {
      print('Error fetching products: $e');
      // Handle error accordingly, e.g., show an error message
    }
  }

  
  void navigateToProductDetailsScreen(Product product) {
    Navigator.pushNamed(context, ProductDetailsScreen.routeName,
        arguments: product);
  }

  void fetchCategories() async {
    try {
      List<dynamic>? fetchedCategories =
          await homeServices.fetchCategories(context);
      setState(() {
        categories = fetchedCategories;
      });
    } catch (e) {
      print('Error fetching categories: $e');
      // Handle error accordingly, e.g., show an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(color: GlobalVariables.backgroundColor),
          ),
          leadingWidth: 60,
          title: Row(
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
                      onFieldSubmitted: (value) {},
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
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Search here...',
                        hintStyle: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
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
      body: ListView(
        children: [
          const CarouselWidget(),
          const SizedBox(height: 10),
          categories == null
              ? const Loader()
              : TopCategories(categories: categories!),
          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Top Products",
                  style: TextStyle(
                      fontFamily: "Montserrat", fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "View All",
                    style: TextStyle(
                        fontFamily: "Montserrat", fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),

          const SizedBox(height: 10),
          
          if(products != null) 
            Column(
              children: products!.map((item) {
                return GestureDetector(
                  onTap: () => navigateToProductDetailsScreen(item),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SearchedProduct(product: item),
                  ),
                );
              }).toList(),
            )
        ],
      ),
    );
  }
}
