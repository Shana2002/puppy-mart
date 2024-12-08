import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/class/cart_class.dart';
import 'package:puppymart/providers/cart_provider.dart';
import 'package:puppymart/services/firebase_service.dart';
import 'package:puppymart/utilities/CustomColors.dart';
import 'package:puppymart/utilities/capitalize_text.dart';

class HomePageAppBar extends StatefulWidget {
  const HomePageAppBar({super.key});

  @override
  State<HomePageAppBar> createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  double? _deviceHeight, _deviceWidth;

  FirebaseService? _firebaseService;
  String? countItems;
  CartProvider? _cartProvider;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
    _cartProvider = GetIt.instance.get<CartProvider>();
    _cartProvider!.updateCount();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return AnimatedBuilder(
        animation: _cartProvider!,
        builder: (context, child) {
          return Container(
            height: _deviceHeight! * 0.07,
            padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Good Morning!",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    Text(
                      CapitalizeText(
                              text: _firebaseService!.currentUser!["name"]
                                  .toString())
                          .capitalize(),
                      style: TextStyle(
                          color: Customcolors().primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    )
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'cart');
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              size: 30,
                              color: Customcolors().accent,
                            ),
                            Positioned(
                              child: Container(
                                  width: 20,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Text(
                                    _cartProvider!.count.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  )),
                              right: -7,
                              top: -5,
                            ),
                          ],
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: Icon(
                        Icons.notifications,
                        size: 30,
                        color: Customcolors().accent,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
        });
  }
}
// return ValueListenableBuilder<int>(
        // valueListenable: _cartProvider!.count,
        // builder: (context, countItems, child) {
        //   return Container();
        // })
