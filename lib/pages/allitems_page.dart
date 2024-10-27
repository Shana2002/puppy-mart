import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/pages/item_page.dart';
import 'package:puppymart/services/firebase_service.dart';
import 'package:puppymart/utilities/CustomColors.dart';
import 'package:puppymart/widgets/home_page_app_bar.dart';

class AllitemsPage extends StatefulWidget {
  AllitemsPage({super.key});

  @override
  State<AllitemsPage> createState() => _AllitemsPageState();
}

class _AllitemsPageState extends State<AllitemsPage> {
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
    return Column(
      children: [
        HomePageAppBar(),
        _searchBar(),
        _productGridview(),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      height: _deviceHeight! * 0.06,
      child: SearchBar(
        hintText: "Search here",
        trailing: <Widget>[
          IconButton(onPressed: () {}, icon: Icon(Icons.search))
        ],
      ),
    );
  }

  Widget _allItems(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: _deviceHeight! * 0.03),
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      height: _deviceHeight! * 0.65, // Set a fixed height to enable scrolling
      child: GridView.count(
        crossAxisCount: 2, // Two items per row
        crossAxisSpacing: 10, // Horizontal space between items
        mainAxisSpacing: 10, // Vertical space between items
        childAspectRatio: (1 / 1.5),
        children: <Widget>[
          _itemContainer(context),
          _itemContainer(context),
          _itemContainer(context),
          _itemContainer(context),
          _itemContainer(context),
          _itemContainer(context),
          _itemContainer(context),
        ],
      ),
    );
  }

  Widget _itemContainer(BuildContext context) {
    return GestureDetector(
      
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
                minWidth: 250, maxHeight: 200, minHeight: 200, maxWidth: 250),
            child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("assests/images/food.png")))),
          ),
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

  Widget _productGridview() {
    return Container(
      margin: EdgeInsets.only(top: _deviceHeight! * 0.03),
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      height: _deviceHeight! * 0.65,
      child: StreamBuilder(
          stream: _firebaseService!.getProducts(),
          builder: (_context, snapshot) {
            if (snapshot.hasData) {
              List _products =
                  snapshot.data!.docs.map((e) => e.data()).toList();
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      childAspectRatio: (1 / 1.3)),
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    Map _product = _products[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext _context) {
                          return ItemPage(product: _product);
                        }));
                      },
                      child: Container(
                        color: Colors.white,
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
                              _product['name'],
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
                      ),
                    );
                  });
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
}
