import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:five_pointed_star/five_pointed_star.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/class/review_class.dart';
import 'package:puppymart/pages/item_page.dart';
import 'package:puppymart/services/firebase_service.dart';
import 'package:puppymart/utilities/capitalize_text.dart';
import 'package:puppymart/widgets/home_page_app_bar.dart';
import 'package:puppymart/widgets/rating_star.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HomePageAppBar(),
            _dogBanner(),
            SizedBox(
              height: 20,
            ),
            _topSaleContainer("Top Sale"),
            _itemConatiner(),
            _topSaleContainer("Top Offers"),
            _itemConatiner(),
          ],
        ),
      ),
    );
  }

  Widget _dogBanner() {
    return Container(
      width: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.20,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage("assests/images/dogBanner.png"))),
    );
  }

  Widget _topSaleContainer(String _name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _name,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
          ),
          const Text(
            "See More",
            style: TextStyle(color: Color.fromRGBO(186, 45, 11, 1)),
          ),
        ],
      ),
    );
  }

  Widget _itemConatiner() {
    return Container(
      margin: EdgeInsets.only(
          left: _deviceWidth! * 0.05,
          top: _deviceHeight! * 0.02,
          bottom: _deviceHeight! * 0.02),
      // margin: EdgeInsets.symmetric(horizontal: _deviceWidth!*0.05,vertical: _deviceHeight!*0.02),
      height: 200,
      child: _prodctListHorizontal(),
    );
  }

  Widget _prodctListHorizontal() {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseService!.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List _products = snapshot.data!.docs.map((e) => e.data()).toList();
            return ListView.builder(
                scrollDirection: Axis.horizontal,
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
                      margin: EdgeInsets.symmetric(horizontal: _deviceWidth!*0.05),
                      padding: EdgeInsets.symmetric(vertical: _deviceHeight!*0.001),
                      width: 160,
                      child: Column(children: [
                        Container(
                          width: 160,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(_product['image'])),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          CapitalizeText(text: _product['name']).capitalize(),
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _reviews(_product['productId'].toString()),
                            Text(_product['price'].toString())
                          ],
                        )
                      ]),
                    ),
                  );
                });
          } else {
            return const CircularProgressIndicator();
          }
        });
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
          } else {
            return Container();
          }
        });
  }
}
