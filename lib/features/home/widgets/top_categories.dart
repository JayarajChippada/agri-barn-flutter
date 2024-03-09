import 'package:appathon/features/categories/screens/categories_screen.dart';
import 'package:appathon/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

class TopCategories extends StatelessWidget {
  final List<dynamic> categories;
  const TopCategories({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Shop by Top Categories",
                style: TextStyle(
                    fontFamily: "Montserrat", fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, CategoriesScreen.routeName);
                },
                child: const Text(
                  "View All",
                  style: TextStyle(
                      fontFamily: "Montserrat", fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Stack(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, SearchScreen.routeName,
                              arguments: categories[index]['_id']),
                          child: Image.network(
                            categories[index]['image'],
                            width: 120,
                            height: 180,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          child: Container(
                            width: 120,
                            color: Colors.black.withOpacity(0.6),
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Text(
                                categories[index]['name'],
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
