import 'package:appathon/common/loader.dart';
import 'package:appathon/features/categories/widgets/category.dart';
import 'package:appathon/features/home/services/home_services.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  static const String routeName = '/categories-screen';
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<dynamic>? categories;
  HomeServices homeServices = HomeServices();

  @override
  void initState() {
    fetchCategories();
    super.initState();
  }

  void fetchCategories() async {
    List<dynamic>? fetchedCategories =
        await homeServices.fetchCategories(context);
    setState(() {
      categories = fetchedCategories;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Categories",
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 23),
        ),
      ),
      body: categories != null
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 20,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, mainAxisSpacing: 50),
                      itemCount: categories!.length,
                      itemBuilder: (context, index) {
                        return Transform.scale(
                            scaleY: 1.25,
                            child: MyCategory(
                              image: categories![index]['image'],
                              id: categories![index]['_id'],
                              text: categories![index]['name'],
                            ));
                      },
                    ),
                  )
                ],
              ),
            )
          : const Loader(),
    );
  }
}
