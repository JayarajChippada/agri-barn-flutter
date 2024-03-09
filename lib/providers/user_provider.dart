import 'package:appathon/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: "",
      firstName: "",
      lastName: "",
      email: "",
      password: "",
      address: "",
      phoneNumber: "",
      type: "",
      token: "",
      verified: false,
      orders: [],
      cart: []);

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
