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
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return ValueListenableBuilder<int>(valueListenable: _cartProvider!, builder: (context,_cartProvider.count))
  }
}
