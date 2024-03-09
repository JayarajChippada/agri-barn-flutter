import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/features/account/screens/account_screen.dart';
import 'package:appathon/features/cart/screens/cart_screen.dart';
import 'package:appathon/features/categories/screens/categories_screen.dart';
import 'package:appathon/features/home/screens/category_deals_screen.dart';
import 'package:appathon/features/home/screens/home_screen.dart';
import 'package:appathon/features/inventory/screens/inventory_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class MyBottomBar extends StatefulWidget {
  static const routeName = './actual-home';
  const MyBottomBar({super.key});

  @override
  State<MyBottomBar> createState() => _MyBottomBarState();
}

class _MyBottomBarState extends State<MyBottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const CategoriesScreen(),
    MyInventory(),
    const CartScreen(),
    const AccountScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updatePage,
        currentIndex: _page,
        selectedItemColor: GlobalVariables.primaryColor,
        unselectedItemColor: GlobalVariables.iconsColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        items: [
          // Home
          BottomNavigationBarItem(
              label: 'Home',
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 0
                                ? GlobalVariables.primaryColor
                                : Colors.transparent,
                            width: bottomBarBorderWidth))),
                child: const Icon(Icons.home_outlined),
              )),

          // Categories
          BottomNavigationBarItem(
              label: 'Categories',
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 1
                                ? GlobalVariables.primaryColor
                                : Colors.transparent,
                            width: bottomBarBorderWidth))),
                child: const Icon(Icons.category_outlined),
              )),

              BottomNavigationBarItem(
                  label: 'Inventory',
                  icon: Container(
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: _page == 2
                                    ? GlobalVariables.primaryColor
                                    : Colors.transparent,
                                width: bottomBarBorderWidth))),
                    child: const Icon(Icons.inventory_2_outlined),
                  )),

          // Cart
          BottomNavigationBarItem(
              label: 'Cart',
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 3
                                ? GlobalVariables.primaryColor
                                : Colors.transparent,
                            width: bottomBarBorderWidth))),
                child: const badges.Badge(
                  badgeContent: Text("2"),
                  badgeStyle:
                      badges.BadgeStyle(elevation: 0, badgeColor: Colors.white),
                  child: Icon(Icons.shopping_cart_outlined),
                ),
              )),

          BottomNavigationBarItem(
              label: 'Profile',
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 4
                                ? GlobalVariables.primaryColor
                                : Colors.transparent,
                            width: bottomBarBorderWidth))),
                child: const Icon(Icons.person_2_outlined),
              )),
        ],
      ),
    );
  }
}
