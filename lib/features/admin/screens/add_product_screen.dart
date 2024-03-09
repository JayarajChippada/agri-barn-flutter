import 'dart:io';
import 'package:appathon/constants/utils.dart';
import 'package:appathon/features/admin/services/admin_services.dart';
import 'package:appathon/features/auth/widgets/custom_button.dart';
import 'package:appathon/features/auth/widgets/custom_textfield.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController rentalPriceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController purchaseUnitController = TextEditingController();
  final TextEditingController rentalUnitController = TextEditingController();
  final AdminSevices adminSevices = AdminSevices();

  bool valuefirst = false;
  bool valuesecond = false;
  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  var productCategories = [];
  String selectedCategory = '';
  String selectedCategoryId = '';

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void fetchCategories() async {
    productCategories = await adminSevices.fetchCategories(context);
    if (productCategories.isNotEmpty) {
      setState(() {
        selectedCategoryId = productCategories[0]['_id'];
        selectedCategory = productCategories[0]['name'];
      });
    }
  }

  void sellProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      // Validate input fields
      if (!isValidNumeric(purchasePriceController.text) ||
          !isValidNumeric(rentalPriceController.text)) {
        // Show error message for invalid input
        print('Please enter valid numeric values for price.');
        return;
      }

      // Parse input strings to double
      double purchasePrice =
          double.tryParse(purchasePriceController.text) ?? 0.0;
      double rentalPrice = double.tryParse(rentalPriceController.text) ?? 0.0;

      // Proceed with selling product
      adminSevices.sellProduct(
        context: context,
        name: productNameController.text,
        description: descriptionController.text,
        categoryId: selectedCategoryId,
        image: images[0],
        purchasePrice: purchasePrice,
        purchaseUnit: purchaseUnitController.text,
        rentalPrice: rentalPrice,
        rentalUnit: rentalUnitController.text,
      );
    }
  }

  bool isValidNumeric(String value) {
    final RegExp numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');
    return numericRegex.hasMatch(value);
  }


  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    purchasePriceController.dispose();
    rentalUnitController.dispose();
    rentalPriceController.dispose();
    purchaseUnitController.dispose();
  }

  String? findIndexById(String id) {
    for (int i = 0; i < productCategories.length; i++) {
      if (productCategories[i]['name'] == id) {
        return productCategories[i]['_id'];
      }
    }
    return null; // Return null if the id is not found
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
          title: const Text(
            'Add Product',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addProductFormKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                images.isNotEmpty
                    ? CarouselSlider(
                        items: images.map((i) {
                          return Builder(
                            builder: (context) {
                              return Image.file(
                                i,
                                fit: BoxFit.cover,
                                height: 200,
                              );
                            },
                          );
                        }).toList(),
                        options:
                            CarouselOptions(viewportFraction: 1, height: 200),
                      )
                    : GestureDetector(
                        onTap: selectImages,
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(10),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.folder_open,
                                  size: 40,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'Select Product Images',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade400,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextField(
                  hintText: 'Product Name',
                  controller: productNameController,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  hintText: 'Description',
                  controller: descriptionController,
                  maxlines: 7,
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Buy ',
                      style: TextStyle(fontSize: 17.0),
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      value: valuefirst,
                      onChanged: (value) {
                        setState(() {
                          valuefirst = value!;
                        });
                      },
                    ),
                    const Text(
                      'Rent ',
                      style: TextStyle(fontSize: 17.0),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      value: valuesecond,
                      onChanged: (value) {
                        setState(() {
                          valuesecond = value!;
                        });
                      },
                    ),
                  ],
                ),
                valuefirst
                    ? Container(
                        child: CustomTextField(
                          hintText: 'Purchase Price',
                          controller: purchasePriceController,
                          textInputType: TextInputType.number,
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                valuefirst
                    ? Container(
                        child: CustomTextField(
                          hintText: 'Purchase Unit',
                          controller: purchaseUnitController,
                          textInputType: TextInputType.text,
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                valuesecond
                    ? CustomTextField(
                        hintText: 'Rental Price',
                        controller: rentalPriceController,
                        textInputType: TextInputType.number,
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                valuesecond
                    ? CustomTextField(
                        hintText: 'Rental Unit',
                        controller: rentalUnitController,
                        textInputType: TextInputType.text,
                      )
                    : Container(),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButton(
                    value: selectedCategory,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories
                        .map<DropdownMenuItem<String>>((category) {
                      return DropdownMenuItem<String>(
                        value: category['name'],
                        child: Text(category['name']),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        selectedCategory = newVal!;
                        selectedCategoryId = findIndexById(selectedCategory)!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: "Sell",
                  onTap: sellProduct,
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
