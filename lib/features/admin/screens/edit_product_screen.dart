import 'dart:io';
import 'package:appathon/constants/utils.dart';
import 'package:appathon/features/admin/services/admin_services.dart';
import 'package:appathon/features/auth/widgets/custom_button.dart';
import 'package:appathon/features/auth/widgets/custom_textfield.dart';
import 'package:appathon/features/search/services/search_services.dart';
import 'package:appathon/models/product_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = '/edit-product';
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController purchasePriceController = TextEditingController();
  final TextEditingController rentalPriceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController purchaseUnitController = TextEditingController();
  final TextEditingController rentalUnitController = TextEditingController();
  AdminSevices adminSevices = AdminSevices();
  SearchServices searchServices = SearchServices();

  bool valuefirst = false;
  bool valuesecond = false;

  String category = 'Mobiles';

  List<File> images = [];
  final _addProductFormKey = GlobalKey<FormState>();

  List<String> productCategories = [
    'Mobiles',
    'Essentials',
    'Appliances',
    'Books',
    'Fashion'
  ];
  @override
  void initState()  {
    fetchProduct();
    super.initState();
  }

  void fetchProduct() async {
    final id = ModalRoute.of(context)!.settings.arguments;
    Product data = await searchServices.fetchProductById(
        context: context, searchQuery: id.toString());
    productNameController.text = data.name;
    descriptionController.text = data.description;
    categoryController.text = data.categoryId;
    purchasePriceController.text = data.purchasePrice.toString();
    rentalPriceController.text = data.rentalPrice.toString();
    purchaseUnitController.text = data.purchaseUnit;
    rentalUnitController.text = data.rentalUnit;
  }

  void updateProduct() {
    if (_addProductFormKey.currentState!.validate() && images.isNotEmpty) {}
  }

  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productNameController.dispose();
    descriptionController.dispose();
    purchasePriceController.dispose();
    rentalPriceController.dispose();
    purchaseUnitController.dispose();
    rentalUnitController.dispose();
    categoryController.dispose();
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
                                borderRadius: BorderRadius.circular(10)),
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
                // Row(children: [TextFormField(),GestureDetector()],),
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
                      checkColor: Colors.greenAccent,
                      activeColor: Colors.red,
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
                      ))
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
                    value: category,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: productCategories.map((String item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newVal) {
                      setState(() {
                        category = newVal!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: "Done",
                  onTap: updateProduct,
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
