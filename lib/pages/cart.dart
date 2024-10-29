import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/class/cart_class.dart';
import 'package:puppymart/pages/item_page.dart';
import 'package:puppymart/services/firebase_service.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  double? _deviceHeight, _deviceWidth;
  CartClass? _cartClass;
  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _cartClass = GetIt.instance.get<CartClass>();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          _appBar(),
          SizedBox(
            height: 10,
          ),
          _cartItemContainer(),
          _bottomConatiner(),
        ],
      )),
    );
  }

  Widget _appBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back)),
          const Text(
            "Cart",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          Container(
            width: _deviceHeight! * 0.06,
            height: _deviceHeight! * 0.06,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: const DecorationImage(
                  image: AssetImage("assests/images/about1.jpg"),
                  fit: BoxFit.cover),
            ),
          )
        ],
      ),
    );
  }

  Widget _cartItemContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      height: _deviceHeight! * 0.7,
      child: _cartView1(),
    );
  }

  Widget _cartView() {
    return ListView(
      children: [],
    );
  }

  Widget _bottomConatiner() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              top:
                  BorderSide(width: 0.5, color: Color.fromARGB(190, 0, 0, 0)))),
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      height: _deviceHeight! * 0.146,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Total ",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              Text(
                "LKR 1920",
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
            ],
          ),
          SizedBox(
            width: _deviceWidth! * 0.9,
            child: TextButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (BuildContext _context) {
                //   return const ItemPage();
                // }));
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                backgroundColor: const Color.fromARGB(255, 255, 83, 83),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Order Now',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<Widget> _listTile(Map? _item) async {
    String _productId = _item!['id'];
    Map<String, dynamic> _productDetail = await _firebaseService!.getProductDetails(_productId);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: _deviceHeight! * 0.01),
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 0,
              blurRadius: 20, // Increased blur radius
              offset: Offset(0, 4),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: 90,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(_productDetail['image']))),
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pedegree 400g",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    "LKR 1000",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.01),
            height: 85,
            width: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color.fromARGB(64, 167, 167, 167),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Icon(Icons.add),
                ),
                Text(
                  _item!['qty'].toString(),
                  style: TextStyle(fontSize: 15),
                ),
                Container(
                  child: Icon(Icons.remove),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _cartView1() {
    List? _cart = _cartClass!.cart;
    return ListView.builder(
        itemCount: _cart.length,
        itemBuilder: (BuildContext _context, int _index) {
          if (_cart.isNotEmpty) {
            Map _itemCart = _cart[_index];
            return _listTile(_itemCart);
          } else {
            return Center(
              child: Text("empty"),
            );
          }
        });
  }
}
