import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:puppymart/class/order_class.dart';
import 'package:puppymart/utilities/CustomColors.dart';
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
            SizedBox(
              height: 20,
            ),
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
      height: _deviceHeight! * 0.8,
      child: StreamBuilder(
          stream: OrderClass().recentOrders(),
          builder: (context, snapshoot) {
            if (snapshoot.hasData) {
              List orders = snapshoot.data!.docs.map((e) => e.data()).toList();
              return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    Map order = orders[index];
                    return _orderhistoryTile(order);
                  });
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }

  Widget _orderhistoryTile(Map _order) {
    Timestamp timestamp = _order["dateTime"];
    DateTime _datetime = timestamp.toDate();
    String _dateformat =
        "${_datetime.year}-${_datetime.month}-${_datetime.day} ${_datetime.hour}:${_datetime.minute}";
    print(_datetime);
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: _deviceWidth! * 0.03, vertical: _deviceHeight! * 0.005),
      padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth! * 0.02, vertical: _deviceHeight! * 0.02),
      decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        spreadRadius: 0,
                        blurRadius: 20, // Increased blur radius
                        offset: Offset(0, 4),
                      )
                    ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [Text(_dateformat,style: TextStyle(color: Customcolors().primary),), Text("Total : LKR  ${_order['subtotal']}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)],
          ),
          Text("Pending",style: TextStyle(color: const Color.fromARGB(255, 15, 112, 18)),)
        ],
      ),
    );
  }
}
