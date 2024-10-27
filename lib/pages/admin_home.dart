import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/pages/orders_admin.dart';
import 'package:puppymart/pages/products_admin.dart';
import 'package:puppymart/services/firebase_service.dart';
import 'package:puppymart/utilities/CustomColors.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  double? _deviceHeight, _deviceWidth;

  FirebaseService? _firebaseService;

  final List<Widget> _pages = [
    ProductsAdmin(),
    OrdersAdmin(),
  ];
  int _currntPage = 0;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Customcolors().primary,
        foregroundColor: Customcolors().background,
        onPressed: () {
          Navigator.pushNamed(context, 'add_product');
        },
        label: const Text("Add Product"),
        icon: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
          child: Column(
            children: [
              Container(
                height: _deviceHeight! * 0.07,
                child: _appBar(),
              ),
              Container(
                height: _deviceHeight! * 0.74,
                child: _pages[_currntPage],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Admin Panel",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
        GestureDetector(
          child: Icon(
            Icons.logout,
            color: Customcolors().accent,
          ),
          onTap: () {
            _firebaseService!.logout();
            Navigator.popAndPushNamed(context, 'landing');
          },
        )
      ],
    );
  }

  Widget _buttonRow() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              child: const Text(
            "Products",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          GestureDetector(
              child: const Text(
            "Orders",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
        ],
      ),
    );
  }
// sandali sanara
  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
        unselectedItemColor: Color.fromARGB(255, 190, 190, 190),
        onTap: (_index) {
          setState(() {
            _currntPage = _index;
          });
        },
        backgroundColor: Customcolors().primary,
        elevation: 5,
        currentIndex: 0,
        iconSize: 25,
        fixedColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(label: "Products", icon: Icon(Icons.shop)),
          BottomNavigationBarItem(
              label: "Cart", icon: Icon(Icons.shopping_cart)),
        ]);
  }
}
