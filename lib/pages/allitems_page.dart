import 'dart:math';

import 'package:five_pointed_star/five_pointed_star.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/class/favourite_class.dart';
import 'package:puppymart/class/review_class.dart';
import 'package:puppymart/pages/item_page.dart';
import 'package:puppymart/services/firebase_service.dart';
import 'package:puppymart/utilities/CustomColors.dart';
import 'package:puppymart/widgets/favourite_icon.dart';
import 'package:puppymart/widgets/home_page_app_bar.dart';

class AllitemsPage extends StatefulWidget {
  AllitemsPage({super.key});

  @override
  State<AllitemsPage> createState() => _AllitemsPageState();
}

class _AllitemsPageState extends State<AllitemsPage> {
  double? _deviceHeight, _deviceWidth;

  FirebaseService? _firebaseService;
  TextEditingController _searchController = TextEditingController();
  List _allProducts = [];
  List _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
    _searchController.addListener(_onSearchChanged);
    _loadProducts();
  }
   @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _filterProducts(_searchController.text);
  }

  void _loadProducts() async {
    _firebaseService!.getProducts().listen((snapshot) {
      List products = snapshot.docs.map((e) => e.data()).toList();
      setState(() {
        _allProducts = products;
        _filteredProducts = products;
      });
    });
  }

  void _filterProducts(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _filteredProducts = _allProducts
            .where((product) => product['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        _filteredProducts = _allProducts;
      });
    }
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
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Search here",
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }

  



  Widget _productGridview() {
    return Container(
      margin: EdgeInsets.only(top: _deviceHeight! * 0.03),
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      height: _deviceHeight! * 0.64,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              childAspectRatio: (1 / 1.3)),
          itemCount: _filteredProducts.length,
          itemBuilder: (context, index) {
            Map _product = _filteredProducts[index];
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
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _reviews(_product['productId'].toString()),
                          Text(_product['price'].toString())
                        ],
                      ),
                    ],
                  ),
                  FavouriteIcon(productId: _product['productId'])
                ]),
              ),
            );
          }),
    );
  }

  Widget _reviews(String _proId) {
    return FutureBuilder(
        future:
            ReviewClass().reviewsCount(_proId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int currentRate = snapshot.hasData ? snapshot.data! : 4;
            return FivePointedStar(
              count: 5,
              gap: 4,
              size: const Size(13, 13),
              defaultSelectedCount: currentRate==0? 4: currentRate,
              selectedColor: Colors.yellow,
              disabled: true,
            );
          }
          else {
            return Container();
          }
        });
  }
}