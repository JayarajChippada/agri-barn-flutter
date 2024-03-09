import 'package:appathon/common/loader.dart';
import 'package:appathon/features/address/screens/address_screen.dart';
import 'package:appathon/features/auth/widgets/custom_button.dart';
import 'package:appathon/features/cart/services/cart_services.dart';
import 'package:appathon/features/cart/widgets/cart_product.dart';
import 'package:appathon/features/cart/widgets/cart_subtotal.dart';
import 'package:appathon/features/home/widgets/address_box.dart';
import 'package:appathon/features/search/screens/search_screen.dart';
import 'package:appathon/models/orders_model.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart-screen';
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartServices cartServices = CartServices();
  List<Item>? cartList;

  @override
  void initState() {
    getCart();
    super.initState();
  }

  void getCart() async {
    cartList = await cartServices.getCart(context);
    setState(() {});
  }

  void navigateToSearchScreen(String searchQuery) {
    Navigator.pushNamed(context, SearchScreen.routeName,
        arguments: searchQuery);
  }

  void navigateToAdressScreen(double sum) {
    cartServices.placeOrder(context: context, cart: cartList!, amount: 0);
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: sum.toString());
  }

  @override
  Widget build(BuildContext context) {
    double totalPurchasePrice = cartList != null
        ? cartList!.fold(
            0.0,
            (previousValue, item) =>
                previousValue + item.product.purchasePrice * item.unit,
          )
        : 0.0;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
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
                      onFieldSubmitted: navigateToSearchScreen,
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
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w500),
                      ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressBox(),
            const CartSubTotal(),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Transform.scale(
                scaleY: 0.9,
                child: CustomButton(
                  text: "Proceed to Buy (${cartList?.length ?? 0} items)",
                  onTap: () => navigateToAdressScreen(totalPurchasePrice),
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
              color: Colors.black12.withOpacity(0.08),
              height: 1,
            ),
            const SizedBox(height: 15),
            cartList != null
                ? ListView.builder(
                    shrinkWrap: true,
                    itemCount: cartList!.isNotEmpty ? cartList!.length : 0,
                    itemBuilder: (context, index) => cartList!.isNotEmpty
                        ? CartProduct(
                            product: cartList![index].product,
                            unit: cartList![index].unit,
                          )
                        : const Loader(),
                  )
                : const Loader(),
          ],
        ),
      ),
    );
  }
}
