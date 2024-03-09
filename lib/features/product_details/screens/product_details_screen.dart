import 'package:appathon/common/star.dart';
import 'package:appathon/features/auth/widgets/custom_button.dart';
import 'package:appathon/features/product_details/services/product_details_services.dart';
import 'package:appathon/features/product_details/widgets/quantity_dropdown.dart';
import 'package:appathon/features/search/screens/search_screen.dart';
import 'package:appathon/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final ProductDetailsServices productDetailsServices =
      ProductDetailsServices();

  bool toggled = false;
  double quantity = 1;

  @override
  void initState() {
    super.initState();
  }

  void navigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQuery);
  }

  void addToCart() {
    productDetailsServices.addToCart(
      context: context, 
      id: widget.product.id,
      unit: quantity,
      type: toggled ? 'buy' : 'rent'
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.product.name,
          style: const TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 19),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.product.vendorId,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                        fontSize: 14),
                  ),
                  Stars(rating: widget.product.rating.toDouble())
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Image.network(
                widget.product.image,
                fit: BoxFit.contain,
                height: 250,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.black12,
              height: 2,
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis consectetur tortor ut ultricies consectetur. Nulla facilisi. Integer consequat, velit vel dapibus viverra, eros nisl malesuada purus, vitae faucibus nulla velit nec turpis. Nullam accumsan pharetra est id efficitur. Sed ullamcorper, lorem vel dapibus ullamcorper, tortor massa mattis magna, nec tincidunt leo felis vitae enim. Proin sed urna odio. Vivamus vitae purus ultricies, ullamcorper ipsum eu, malesuada ipsum. Sed lobortis consectetur velit, ut lobortis lacus faucibus ut. Suspendisse potenti. Nulla at libero feugiat, rhoncus tortor nec, suscipit enim. Donec ut urna ipsum. Sed eget mi vel odio convallis tincidunt. Cras tincidunt, libero et hendrerit fermentum, lectus nulla feugiat odio, non placerat arcu dui ut mi.",
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              //child: Text(widget.product.description),
            ),
            Container(
              color: Colors.black12,
              height: 2,
            ),Padding(
                    padding: const EdgeInsets.all(12),
                    child: RichText(
                      text: TextSpan(
                          text: 'Purchase Price:  ',
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text:
                                  '\Rs. ${widget.product.purchasePrice} /${widget.product.purchaseUnit}',
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                          ]),
                    ),
                  ),
           Padding(
                    padding: const EdgeInsets.all(12),
                    child: RichText(
                      text: TextSpan(
                          text: 'Rental Price:  ',
                          style: const TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text:
                                  '\Rs. ${widget.product.rentalPrice} /${widget.product.rentalUnit}',
                              style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500),
                            ),
                          ]),
                    ),
                  ),
            Container(
              color: Colors.black12,
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              toggled = !toggled;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: toggled ? Colors.green : null,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Center(
                                child: Text(
                                  "Buy",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              toggled = !toggled;
                            });
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.25,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: toggled ? null : Colors.green,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5),
                              child: Center(
                                child: Text(
                                  "Rent",
                                  style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  QuantityDropdown(
                    initialQuantity: 1,
                    onChanged: (value) {
                      quantity = value.toDouble();
                    },
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CustomButton(
                text: 'Add to Cart',
                onTap: addToCart,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
