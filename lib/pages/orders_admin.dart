import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/class/order_class.dart';
import 'package:puppymart/pages/order_view.dart';
import 'package:puppymart/services/firebase_service.dart';
import 'package:puppymart/utilities/CustomColors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersAdmin extends StatefulWidget {
  const OrdersAdmin({super.key});

  @override
  State<OrdersAdmin> createState() => _OrdersAdminState();
}

class _OrdersAdminState extends State<OrdersAdmin> {
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
      child: _orderList(),
    );
  }

  Widget _orderList() {
    return Container(
      height: _deviceHeight! * 0.8,
      child: StreamBuilder(
          stream: OrderClass().allOrders(),
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
            children: [
              Text(
                _dateformat,
                style: TextStyle(color: Customcolors().primary),
              ),
              Text(
                "Total : LKR  ${_order['subtotal']}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext _context) {
                  return OrderView(order: _order);
                }));
              },
              child: Icon(
                Icons.arrow_right_alt,
                size: 25,
              ))
        ],
      ),
    );
  }
}
