import 'package:get_it/get_it.dart';
import 'package:puppymart/services/firebase_service.dart';

class CartClass {
  String cusID;
  String? productId;
  String? qty;
  List cart = [];
  FirebaseService? _firebaseService;
  CartClass({required this.cusID}) {
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  void addTocart(String id, int qty) {
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
      Map _cart = {"id": id, "qty": qty};
      cart.add(_cart);
    }
    // fetchDataAndPrint();
  }

  // void fetchDataAndPrint() async {
  //   List<Map<String, dynamic>> dataList = await _firebaseService!.getDataList();

  //   // Print each document data
  //   print(dataList[1]['name']);
  // }
}
