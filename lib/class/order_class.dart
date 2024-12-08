import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/class/cart_class.dart';
import 'package:puppymart/services/firebase_service.dart';

final String ORDER_COLLECTION = 'order';

class OrderClass extends FirebaseService {
  String? customer;
  CartClass? _cartClass;
  String status = "pending";
  OrderClass() {
    _cartClass = GetIt.instance.get<CartClass>();
  }

  Future<bool> addToOrder() async {
    try {
      customer = auth.currentUser!.uid;
      String _orderId =
          Timestamp.now().microsecondsSinceEpoch.toString() + customer!;
      await db.collection(ORDER_COLLECTION).doc(_orderId).set({
        "orderId": _orderId,
        "customer": customer,
        "dateTime": DateTime.now(),
        "orderlist": _cartClass!.cart,
        "subtotal": _cartClass!.calculateSum(),
        "status": status,
      });
      _cartClass!.clearCart();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> recentOrders() {
    return db
        .collection('order')
        .where("customer", isEqualTo: auth.currentUser!.uid)
        .snapshots();
  }

  Stream<QuerySnapshot> allOrders() {
    return db.collection('order').snapshots();
  }
}
