import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/providers/cart_provider.dart';
import 'package:puppymart/services/firebase_service.dart';

class CartClass {
  String cusID;
  String? productId;
  String? qty;
  List cart = [];
  FirebaseService? _firebaseService;
  CartProvider? _cartProvider;
  CartClass({required this.cusID}) {
    _firebaseService = GetIt.instance.get<FirebaseService>();
    _cartProvider = GetIt.instance.get<CartProvider>();
  }

  void addTocart(String id, int qty, int price) {
    int _index = 0;
    bool isHave = false;

    for (var element in cart) {
      if (element["id"] == id) {
        isHave = true;
        break;
      }
      _index++;
    }
    if (isHave) {
      cart[_index]["qty"] = cart[_index]["qty"] + qty;
    } else {
      Map _cart = {"id": id, "qty": qty, "price": price};
      cart.add(_cart);
    }
    calculateSum();
    _cartProvider!.updateCount();
  }

  void minesCart(String id) {
    int _index = 0;
    bool isRemove = false;

    for (var element in cart) {
      if (element["id"] == id) {
        element["qty"] <= 1 ? isRemove = true : isRemove = false;
        break;
      }
      _index++;
    }

    isRemove
        ? removeCart(_index)
        : cart[_index]['qty'] = cart[_index]['qty'] - 1;
    print(cart.length);
    calculateSum();
    _cartProvider!.updateCount();
  }

  num calculateSum() {
    countCart();
    if (cart.isEmpty) {
      return 0;
    } else {
      num total = 0;
      for (var element in cart) {
        total = total + element['price'] * element['qty'];
      }
      return total;
    }
  }

  void removeCart(int index) {
    cart.removeAt(index);
    if (cart.isEmpty) {
      cart.clear();
    }
    calculateSum();
    _cartProvider!.updateCount();
  }

  int countCart() {
    if (cart.isEmpty) {
      return 0;
    } else {
      return cart.length;
    }
  }

  void clearCart() {
    cart.clear();
    _cartProvider!.updateCount();
  }
}
