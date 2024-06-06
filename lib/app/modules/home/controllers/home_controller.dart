import 'package:event_digital/app/data/model/model_category.dart';
import 'package:event_digital/app/data/model/model_product.dart';
import 'package:event_digital/app/data/model/model_user.dart';
import 'package:event_digital/app/data/services/api_services.dart';
import 'package:event_digital/app/data/services/user_services.dart';
import 'package:event_digital/core/assets.dart';
import 'package:event_digital/app/data/model/model_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeController extends GetxController {
  String? selectedCategory;
  ModelProfile? profile;

  void setCategory(String name) {
    selectedCategory = name;
    update();
    getFilterProduct();
  }

  getProfile() async {
    ModelUser? user = UserService.find.user;
    profile = await ApiServices().getProfile(user?.id);
    update();
  }

  final List _shopItems = const [
    // [ itemName, itemPrice, imagePath, color ]
    ["Avocado", "4.00", '', Colors.green],
    ["Banana", "2.50", '', Colors.yellow],
    ["Chicken", "12.80", '', Colors.brown],
    ["Water", "1.00", '', Colors.blue],
  ];

  // list of cart items
  List _cartItems = [];

  get cartItems => _cartItems;

  get shopItems => _shopItems;

  // add item to cart
  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    update();
  }

  String formatPrice(num productPrice) {
    final formatter = NumberFormat.currency(
      symbol: 'Rp',
      decimalDigits: 0,
      locale: 'id_ID',
    );
    return formatter.format(productPrice);
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    update();
  }

  // calculate total price
  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
    }
    return totalPrice.toStringAsFixed(2);
  }

  ModelProduct? allProudct;
  getAllProduct() async {
    var data = await ApiServices().getAllProduct();
    if (data != null) {
      allProudct = data;
      update();
    }
  }

  getFilterProduct() async {
    var data = await ApiServices().filterCategory(selectedCategory);
    if (data != null) {
      allProudct = data;
      update();
    }
  }

  ModelCategory? allCategory;
  getCategory() async {
    var data = await ApiServices().getCategory();
    if (data != null) {
      allCategory = data;
      update();
    }
  }

  @override
  void onReady() async {
    getAllProduct();
    getCategory();
    getProfile();

    var dataLogin = await UserService.find.getLocalUser();

    print('hai ${dataLogin?.isLogin}');
    super.onReady();
  }
}
