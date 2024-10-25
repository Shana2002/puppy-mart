import 'package:flutter/material.dart';
import 'package:puppymart/utilities/custom_text.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  double? _deviceHeight, _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _topBar(),
            _orderList()
          ],
        ),
      ),
    );
  }

  Widget _topBar() {
    return SizedBox(
      height: _deviceHeight! * 0.05,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
          SizedBox(
            width: 10,
          ),
          CustomText.titleText("Order History"),
        ],
      ),
    );
  }

  Widget _orderList() {
    return Container(
      height: _deviceHeight!* 0.7,
      child: ListView(
        children: [
          ListTile(
            title: Text("data"),
          ),
          ListTile(
            title: Text("data"),
          ),
          ListTile(
            title: Text("data"),
          ),
          ListTile(
            title: Text("data"),
          ),
        ],
      ),
    );
  }
}
