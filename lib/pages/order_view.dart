import 'package:flutter/material.dart';
import 'package:puppymart/class/user_class.dart';
import 'package:puppymart/utilities/CustomColors.dart';

class OrderView extends StatefulWidget {
  Map order;
  OrderView({super.key, required this.order});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  double? _deviceHeight, _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Customcolors().secondory,
        leading: Icon(Icons.arrow_back),
        title: Text(widget.order['orderId']),
      ),
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: _deviceWidth! * 0.05, vertical: _deviceWidth! * 0.01),
        child: _customerDetails(),
      )),
    );
  }

  Widget _customerDetails() {
    return FutureBuilder(
        future: UserClass().getUserName(widget.order['customer']),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map userDetails = snapshot.data!;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Name",
                      style: _orderText(),
                    ),
                    Container(
                        width: _deviceWidth! * 0.6,
                        child: Text(
                          userDetails['name'],
                          style: _orderText(),
                          textAlign: TextAlign.right,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Address",
                      style: _orderText(),
                    ),
                    Container(
                        width: _deviceWidth! * 0.6,
                        child: Text(
                          userDetails['name'],
                          style: _orderText(),
                          textAlign: TextAlign.right,
                        )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      "Mobile",
                      style: _orderText(),
                    ),
                    Container(
                        width: _deviceWidth! * 0.6,
                        child: Text(
                          userDetails['name'],
                          style: _orderText(),
                          textAlign: TextAlign.right,
                        )),
                  ],
                )
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }


  TextStyle _orderText() {
    return TextStyle(
        color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500);
  }
}
