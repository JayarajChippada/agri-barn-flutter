import 'package:appathon/common/loader.dart';
import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/features/home/services/home_services.dart';
import 'package:appathon/features/home/widgets/carousel_slider.dart';
import 'package:appathon/features/home/widgets/top_categories.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic>? categories;
  HomeServices homeServices = HomeServices();

  @override
  void initState() {
    fetchCategories();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    fetchCategories();
    super.didChangeDependencies();
  }

  void fetchCategories() async {
    List<dynamic>? fetchedCategories = await homeServices.fetchCategories(context);
    setState(() {
      categories = fetchedCategories;
    });
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
      body: ListView(
        children: [
          const CarouselWidget(),
          const SizedBox(
            height: 10,
          ),
          categories == null 
          ? const Loader()
          :TopCategories(
            categories: categories!,
          ),
        ],
      ),
    );
  }
}
