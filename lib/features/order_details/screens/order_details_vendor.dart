import 'package:appathon/features/admin/screens/admin_screen.dart';
import 'package:appathon/features/auth/widgets/custom_button.dart';
import 'package:appathon/features/product_details/services/product_details_services.dart';
import 'package:appathon/features/search/screens/search_screen.dart';
import 'package:appathon/models/orders_model.dart';
import 'package:flutter/material.dart';

// Define enum for order status
enum OrderStatus { pending, completed, received, delivered }

// Convert order status strings to enum values
OrderStatus getOrderStatusFromString(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return OrderStatus.pending;
    case 'completed':
      return OrderStatus.completed;
    case 'received':
      return OrderStatus.received;
    case 'delivered':
      return OrderStatus.delivered;
    default:
      return OrderStatus.pending;
  }
}

class OrderDetailsVendorScreen extends StatefulWidget {
  static const routeName = 'order-vendor-details';
  final Order order;
  OrderDetailsVendorScreen({super.key, required this.order});

  @override
  State<OrderDetailsVendorScreen> createState() =>
      _OrderDetailsVendorScreenState();
}

class _OrderDetailsVendorScreenState extends State<OrderDetailsVendorScreen> {
  int currentStep = 0;
  ProductDetailsServices productDetailsServices = ProductDetailsServices();
  void navigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQuery);
  }

  @override
  void initState() {
    currentStep = getOrderStatusFromString(widget.order.orderStatus).index;
    super.initState();
  }

  void changeOrderDetails(OrderStatus status) {
    setState(() {
      currentStep = status.index;
    });
    // Call your method to update order status here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "My Orders",
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "View order details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Date: ${widget.order.orderDate}",
                      style: const TextStyle(
                          fontFamily: "Montserrat", fontSize: 15),
                    ),
                    Text(
                      "Order Id: ${widget.order.id}",
                      style: const TextStyle(
                          fontFamily: "Montserrat", fontSize: 15),
                    ),
                    Text(
                      "Order Total: Rs.${widget.order.totalAmount}",
                      style: const TextStyle(
                          fontFamily: "Montserrat", fontSize: 15),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Purchase Details",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    for (int i = 0; i < widget.order.items.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.network(
                              widget.order.items[i].product.image,
                              height: 150,
                              width: 150,
                              fit: BoxFit.contain,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 150,
                                  child: Text(
                                    widget.order.items[i].product.name,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                 SizedBox(
                                  width: 50,
                                  child: Text(
                                    "Qty: ${widget.order.items[i].unit}",
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Tracking",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Column(
                  children: [
                    Stepper(
                      controlsBuilder: (context, details) {
                        return Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: details.onStepContinue,
                                  child: Text('Next'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      steps: [
                        Step(
                          title: const Text('Pending'),
                          content: const Text(
                            'Your order is yet to be delivered',
                          ),
                          isActive: currentStep > 0,
                          state: currentStep > 0
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          title: const Text('Completed'),
                          content: const Text(
                            'Your order has been delivered, you are yet to sign.',
                          ),
                          isActive: currentStep > 1,
                          state: currentStep > 1
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          title: const Text('Received'),
                          content: const Text(
                            'Your order has been delivered and signed by you.',
                          ),
                          isActive: currentStep > 2,
                          state: currentStep > 2
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                        Step(
                          title: const Text('Delivered'),
                          content: const Text(
                            'Your order has been delivered and signed by you!',
                          ),
                          isActive: currentStep >= 3,
                          state: currentStep >= 3
                              ? StepState.complete
                              : StepState.indexed,
                        ),
                      ],
                    ),
                    CustomButton(
                      text: "Mark delivered",
                      onTap: () async {
                        print(widget.order.id);
                        productDetailsServices.orderCompleted(
                            context: context, id: widget.order.id);
                        setState(() {});
                        Navigator.pushReplacementNamed(
                          context,
                          AdminScreen.routeName
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
