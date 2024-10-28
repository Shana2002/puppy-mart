import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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
                CapitalizeText(text: _firebaseService!.currentUser!["name"].toString()).capitalize(),
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
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                    color: Customcolors().accent,
                  )),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.notifications,
                size: 30,
                color: Customcolors().accent,
              )
            ],
          )
        ],
      ),
    );
  }
}
