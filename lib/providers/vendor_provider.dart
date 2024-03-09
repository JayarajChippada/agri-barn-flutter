import 'package:appathon/models/vendor_model.dart';
import 'package:flutter/material.dart';

class VendorProvider extends ChangeNotifier {
  Vendor _vendor = Vendor(
      id: "",
      address: "",
      coverImages: [],
      email: "",
      lat: 0,
      long: 0,
      name: "",
      ownerName: "",
      phoneNumber: "",
      pincode: "",
      products: [],
      serviceAvailable: false,
      token: "",
      type: "vendor"
      );

  Vendor get vendor => _vendor;

  void setUser(String user) {
    _vendor = Vendor.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(Vendor user) {
    _vendor = user;
    notifyListeners();
  }
}
