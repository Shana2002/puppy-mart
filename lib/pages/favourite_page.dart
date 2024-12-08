import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/class/favourite_class.dart';
import 'package:puppymart/pages/item_page.dart';
import 'package:puppymart/services/firebase_service.dart';
import 'package:puppymart/utilities/CustomColors.dart';
import 'package:puppymart/utilities/capitalize_text.dart';
import 'package:puppymart/widgets/favourite_icon.dart';
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
        children: <Widget>[],
      ),
    );
  }

  Widget _allItems1() {
    return Container(
        margin: EdgeInsets.only(top: _deviceHeight! * 0.01),
        padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
        height: _deviceHeight! * 0.71, // Set a fixed height to enable scrolling
        child: favproducr());
  }

  Widget favproducr() {
    return FutureBuilder(
      future: FavouriteClass().favItems(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List favList = snapshot.data!;
          return favProducts(favList);
        } else {
          return Center(
            child: Text("No data here"),
          );
        }
      },
    );
  }

  Widget favProducts(List _favList) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two items per row
          crossAxisSpacing: 10, // Horizontal space between items
          mainAxisSpacing: 10, // Vertical space between items
          childAspectRatio: (1 / 1.5)),
      itemCount: _favList.length,
      itemBuilder: (BuildContext context, int index) {
        return _gridLayout(_favList[index]);
      },
    );
  }

  Widget _gridLayout(String _id) {
    return FutureBuilder(
      future: _firebaseService!.getProductDetails(_id),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Map _product = snapshot.data!;
          return GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext _context) {
                return ItemPage(product: _product);
              }));
            },
            child: Container(
              color: Colors.white,
              child: Stack(children: [
                Column(
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
                                  image: NetworkImage(_product['image'])))),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      _product['name'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
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
                FavouriteIcon(productId: _product['productId']),
              ]),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
