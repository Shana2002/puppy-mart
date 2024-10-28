class CartClass {
  String cusID;
  String? productId;
  String? qty;
  List cart = [];

  CartClass({required this.cusID});

  void addTocart(String id, int qty) {
    Map _cart = {"id": id, "qty": qty};
    cart.add(_cart);
    print(cart);
  }
}
