class CartClass {
  String cusID;
  String? productId;
  String? qty;
  List cart = [];

  CartClass({required this.cusID});

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

    print(cart);
  }
}
