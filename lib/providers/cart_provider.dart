import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/class/cart_class.dart';

class CartProvider extends ChangeNotifier {
  CartClass _cartClass = GetIt.instance.get<CartClass>();
  int count = 0;

  void updateCount() {
    count = _cartClass.countCart();
    print(count);
    notifyListeners();
  }
}
