import 'package:appathon/common/loader.dart';
import 'package:appathon/features/auth/services/auth_services.dart';
import 'package:appathon/features/product_details/screens/product_details_screen.dart';
import 'package:appathon/features/search/widgets/searched_product.dart';
import 'package:appathon/models/product_model.dart';
import 'package:flutter/material.dart';

class TopProducts extends StatefulWidget {
  const TopProducts({Key? key}) : super(key: key);

  @override
  State<TopProducts> createState() => _TopProductsState();
}

class _TopProductsState extends State<TopProducts> {
  AuthService authService = AuthService();
  List<Product>? products;

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return products != null
        ? Expanded(
            child: SizedBox(
              height: 520,
              child: ListView.builder(
                itemCount: products!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () =>
                        navigateToProductDetailsScreen(products![index]),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SearchedProduct(product: products![index]),
                    ),
                  );
                },
              ),
            ),
          )
        : const Loader();
  }
}
