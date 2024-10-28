import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/services/firebase_service.dart';
import 'package:puppymart/utilities/capitalize_text.dart';
import 'package:puppymart/widgets/home_page_app_bar.dart';

class FavouritePage extends StatefulWidget {
  FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
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
    return Container(
      child: Column(
        children: [
          HomePageAppBar(),
          _allItems1(),
        ],
      ),
    );
  }

  Widget _allItems() {
    return Container(
      margin: EdgeInsets.only(top: _deviceHeight! * 0.01),
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      height: _deviceHeight! * 0.71, // Set a fixed height to enable scrolling
      child: GridView.count(
        crossAxisCount: 2, // Two items per row
        crossAxisSpacing: 10, // Horizontal space between items
        mainAxisSpacing: 10, // Vertical space between items
        childAspectRatio: (1 / 1.5),
        children: <Widget>[
          _itemContainer(),
          _itemContainer(),
          _itemContainer(),
          _itemContainer(),
          _itemContainer(),
          _itemContainer(),
          _itemContainer(),
        ],
      ),
    );
  }

  Widget _itemContainer() {
    return GestureDetector(
      onTap: () {
        print("object");
      },
      child: Column(
        children: [
          Container(
              width: 250,
              height: 200,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.contain,
                      image: AssetImage("assests/images/food.png")))),
          const SizedBox(
            height: 5,
          ),
          const Text(
            "Pedegree 400g",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 13,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    size: 13,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    size: 13,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    size: 13,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    size: 13,
                    color: Colors.black,
                  ),
                ],
              ),
              Text("1500")
            ],
          ),
        ],
      ),
    );
  }

  Widget _allItems1() {
    return Container(
        margin: EdgeInsets.only(top: _deviceHeight! * 0.01),
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
        height: _deviceHeight! * 0.71, // Set a fixed height to enable scrolling
        child: StreamBuilder<QuerySnapshot>(
            stream: _firebaseService!.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List _products =
                    snapshot.data!.docs.map((e) => e.data()).toList();
                return GridView.builder(
                    itemCount: _products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two items per row
                        crossAxisSpacing: 10, // Horizontal space between items
                        mainAxisSpacing: 10, // Vertical space between items
                        childAspectRatio: (1 / 1.5)),
                    itemBuilder: (context, index) {
                      Map _product = _products[index];
                      return GestureDetector(
                        onTap: () {
                          print("object");
                        },
                        child: Column(
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  minWidth: 150,
                                  maxHeight: 150,
                                  minHeight: 150,
                                  maxWidth: 150),
                              child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              NetworkImage(_product['image'])))),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              CapitalizeText(text: _product['name'].toString()).capitalize(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w800),
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 13,
                                      color: Colors.yellow,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 13,
                                      color: Colors.yellow,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 13,
                                      color: Colors.yellow,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 13,
                                      color: Colors.yellow,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 13,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                Text("1500")
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return CircularProgressIndicator();
              }
            }));
  }
}
