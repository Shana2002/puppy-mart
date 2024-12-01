import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/services/firebase_service.dart';
import 'package:puppymart/utilities/CustomColors.dart';

class ProductsAdmin extends StatefulWidget {
  const ProductsAdmin({super.key});

  @override
  State<ProductsAdmin> createState() => _ProductsAdminState();
}

class _ProductsAdminState extends State<ProductsAdmin> {
  double? _deviceHeight, _deviceWidth;
  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      width: _deviceHeight!*0.6,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'add_product');
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Customcolors().accent,
                  borderRadius: BorderRadius.circular(20)),
              height: _deviceHeight! * 0.1,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 20,
                      color: Customcolors().background,
                    ),
                    Text(
                      "Add Product",
                      style: TextStyle(
                          fontSize: 20, color: Customcolors().background),
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: _deviceHeight!*0.05),
            height: _deviceHeight! * 0.71,
            child: _productList(),
          ),
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
