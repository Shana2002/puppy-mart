import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/services/firebase_service.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  double? _deviceHeight, _deviceWidth;

  FirebaseService? _firebaseService;

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, 'add_product');
        },
        label: Text("Add Product"),
        icon: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
          child: Column(
            children: [
              Container(
                height: _deviceHeight! * 0.07,
                color: Colors.yellow,
                child: _appBar(),
              ),
              _buttonRow(),
              Container(
                height: 400,
                color: const Color.fromARGB(255, 170, 170, 170),
                child: _productList(),
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
          child: Icon(Icons.logout),
          onTap: () {},
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

  Widget _productList() {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseService!.getProducts(),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            List _products = _snapshot.data!.docs.map((e) => e.data()).toList();
            return ListView.builder(
                itemCount: _products.length,
                itemBuilder: (BuildContext _context, int _index) {
                  Map _product = _products[_index];
                  print(_product);
                  return Container(
                    child: Text(_product["name"]),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
