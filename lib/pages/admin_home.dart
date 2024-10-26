import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
              _buttonRow(),
              Container(
                height: _deviceHeight! * 0.77,
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
          child: Icon(
            Icons.logout,
            color: Customcolors().accent,
          ),
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
                  return GestureDetector(
                    onHorizontalDragEnd: (_details) {
                      print("object");
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: _deviceHeight! * 0.01),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                          bottomLeft: Radius.circular(32),
                        ),
                        child: ListTile(
                          tileColor: Customcolors().secondory,
                          leading: Container(
                            width: _deviceWidth! * 0.20,
                            height: _deviceWidth! * 0.20,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    _product['image'],
                                  )),
                            ),
                          ),
                          title: Text(
                            _product['name'],
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          trailing: Icon(
                            Icons.arrow_right_alt,
                            color: Customcolors().accent,
                          ),
                          subtitle: Text(
                            _product['description'].toString(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
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
