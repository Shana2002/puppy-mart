import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/class/cart_class.dart';

class CartProvider extends ChangeNotifier {
  
  int count = 0;

  void updateCount() {
    CartClass _cartClass = GetIt.instance.get<CartClass>();
    count = _cartClass.countCart();
    print(count);
    notifyListeners();
  }
}
