import 'package:appathon/common/bottom_bar.dart';
import 'package:appathon/features/address/screens/address_screen.dart';
import 'package:appathon/features/admin/screens/add_product_screen.dart';
import 'package:appathon/features/admin/screens/admin_screen.dart';
import 'package:appathon/features/admin/screens/edit_product_screen.dart';
import 'package:appathon/features/auth/screens/auth_screen.dart';
import 'package:appathon/features/auth/screens/login_screen.dart';
import 'package:appathon/features/auth/screens/otp_screen.dart';
import 'package:appathon/features/auth/screens/signup_screen.dart';
import 'package:appathon/features/categories/screens/categories_screen.dart';
import 'package:appathon/features/home/screens/category_deals_screen.dart';
import 'package:appathon/features/home/screens/home_screen.dart';
import 'package:appathon/features/order_details/screens/order_details.dart';
import 'package:appathon/features/order_details/screens/order_details_vendor.dart';
import 'package:appathon/features/product_details/screens/product_details_screen.dart';
import 'package:appathon/features/search/screens/search_screen.dart';
import 'package:appathon/models/orders_model.dart';
import 'package:appathon/models/product_model.dart';
import 'package:flutter/material.dart';

// List of routes for Screens Navigation

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(),
      );

    case SignUpScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const SignUpScreen(),
      );

    case SignInScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const SignInScreen(),
      );


    case OtpScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const OtpScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());

    case MyBottomBar.routeName:
      return MaterialPageRoute(builder: (_) => const MyBottomBar());

    case CategoriesScreen.routeName:
      return MaterialPageRoute(builder: (_) => const CategoriesScreen());


    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
            ));

    case EditProductScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) =>const EditProductScreen());

    case AddProductScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AddProductScreen());

    case AdminScreen.routeName:
      return MaterialPageRoute(builder: (_) => const AdminScreen());

    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ));

    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDealsScreen(
                category: category,
              ));

    case ProductDetailsScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => ProductDetailsScreen(
                product: product,
              ));
    case AddressScreen.routeName:
      var totalAmount = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => AddressScreen(
                totalAmount: totalAmount,
              ));

    case OrderDetailsScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailsScreen(
                order: order,
              ));

    case OrderDetailsVendorScreen.routeName:
      var order = routeSettings.arguments as Order;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => OrderDetailsVendorScreen(
                order: order,
              ));

    

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exist'),
          ),
        ),
      );
  }
}

