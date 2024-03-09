import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/features/account/services/account_services.dart';
import 'package:appathon/features/admin/screens/analytics_screen.dart';
import 'package:appathon/features/admin/screens/orders_screen.dart';
import 'package:appathon/features/admin/screens/posts_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  static const String routeName = '/admin-screen';
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const PostsScreen(),
    const OrdersScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Color(0xFF208B3A)),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'AgriBarn',
                style:
                    TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.black, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: GestureDetector(
                  onTap: () => AccountServices().logOut(context),
                  child: const Text(
                    'LogOut',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 18,
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
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
              label: '',
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 0
                                ? GlobalVariables.primaryColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth))),
                child: const Icon(Icons.home_outlined),
              )),

          // Orders
          BottomNavigationBarItem(
            label: '',
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          color: _page == 2
                              ? GlobalVariables.primaryColor
                              : GlobalVariables.backgroundColor,
                          width: bottomBarBorderWidth))),
              child: const Icon(Icons.all_inbox_outlined),
            ),
          ),
        ],
      ),
    );
  }
}
