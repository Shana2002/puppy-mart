import 'package:flutter/material.dart';

class HomePageAppBar extends StatefulWidget {
  const HomePageAppBar({super.key});

  @override
  State<HomePageAppBar> createState() => _HomePageAppBarState();
}

class _HomePageAppBarState extends State<HomePageAppBar> {
  double? _deviceHeight, _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: _deviceHeight! * 0.10,
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning!",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              Text(
                "Hansaka",
                style: TextStyle(
                    color: Color.fromRGBO(186, 45, 11, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
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
                  )),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.notifications,
                size: 30,
              )
            ],
          )
        ],
      ),
    );
  }
}
