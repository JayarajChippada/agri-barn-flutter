import 'package:appathon/common/loader.dart';
import 'package:appathon/constants/utils.dart';
import 'package:appathon/features/account/widgets/single_product.dart';
import 'package:appathon/features/admin/screens/add_product_screen.dart';
import 'package:appathon/features/admin/screens/edit_product_screen.dart';
import 'package:appathon/features/admin/services/admin_services.dart';
import 'package:appathon/models/product_model.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName);
  }

  void navigateToEditProduct() {
    Navigator.pushNamed(context, EditProductScreen.routeName);
  }

  final AdminSevices adminSevices = AdminSevices();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  fetchAllProducts() async {
    try {
      products = await adminSevices.fetchAllProducts(context);
      print(products);
      setState(() {});
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, e.toString());
    }
  }

  void deleteProduct(Product product, int index) {
    adminSevices.deleteAProduct(
      context: context,
      product: product,
      onSuccess: () {
        products!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              itemCount: products!.length,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = products![index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 120,
                      child: SingleProduct(image: productData.image),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Text(
                              productData.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, EditProductScreen.routeName,
                                arguments: productData.id);
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () => deleteProduct(productData, index),
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xFF208B3A),
              onPressed: navigateToAddProduct,
              tooltip: "Add a Product",
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
