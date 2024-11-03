import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/class/cart_class.dart';
import 'package:puppymart/services/firebase_service.dart';

final String ORDER_COLLECTION = 'order';

class OrderClass extends FirebaseService {
  String? customer;
  CartClass? _cartClass;
  OrderClass() {
    _cartClass = GetIt.instance.get<CartClass>();
  }

  Future<bool> addToOrder() async {
    try {
      customer = auth.currentUser!.uid;
      await db.collection(ORDER_COLLECTION).add({
        "customer": customer,
        "timestamp": Timestamp.now(),
        "orderlist": _cartClass!.cart,
        "subtotal": _cartClass!.calculateSum(),
      });
      _cartClass!.clearCart();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
