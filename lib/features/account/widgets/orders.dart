
import 'package:appathon/common/loader.dart';
import 'package:appathon/constants/global_variables.dart';
import 'package:appathon/features/account/services/account_services.dart';
import 'package:appathon/features/account/widgets/single_product.dart';
import 'package:appathon/features/order_details/screens/order_details.dart';
import 'package:appathon/models/orders_model.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  // temporary list
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  @override
  void initState() {
    fetchOrders();
    super.initState();
  }

  void fetchOrders() async {
    orders = await accountServices.fetchMyOrders(context: context);
    setState(() {
      
    });
  }

  void navigateToOrdersDetailsScreen(Order order) {
    Navigator.pushNamed(context, OrderDetailsScreen.routeName,
        arguments: order);
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
    ? const Loader()
    : Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: const Text(
                "Your Orders",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                right: 15,
              ),
              child: const Text(
                "See all",
                style: TextStyle(color: GlobalVariables.primaryColor),
              ),
            ),
          ],
        ),

        // Display orders

        Container(
          height: 170,
          padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: orders!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => navigateToOrdersDetailsScreen(orders![index]),
                child: SingleProduct(
                            image: orders![index].items[0].product.image)
              );
            },
          ),
        ),
      ],
    );
  }
}
