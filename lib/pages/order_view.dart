import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/class/user_class.dart';
import 'package:puppymart/services/firebase_service.dart';
import 'package:puppymart/utilities/CustomColors.dart';

class OrderView extends StatefulWidget {
  Map order;
  OrderView({super.key, required this.order});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
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
                  height: _deviceHeight! * 0.005,
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
                          "hansaka \n ravishan\n 22 \n dsffds",
                          style: _orderText(),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.right,
                        )),
                  ],
                ),
                SizedBox(
                  height: _deviceHeight! * 0.005,
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
                ),
                SizedBox(
                  height: _deviceHeight! * 0.02,
                ),
                _orderItemList(),
                _bottomContainer(),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget _orderItemList() {
    List _items = widget.order['orderlist'];
    return Container(
      width: _deviceWidth! * 0.9,
      height: _deviceHeight! * 0.6,
      child: ListView.builder(
          itemCount: _items.length,
          itemBuilder: (context, _index) {
            Map _itemdetails = _items[_index];
            return Container(
              margin: EdgeInsets.symmetric(vertical: _deviceHeight! * 0.005),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Customcolors().secondory,
              ),
              child: ListTile(
                title: FutureBuilder(
                    future: _firebaseService!
                        .getProductDetails(_itemdetails['id'].toString()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        Map _productDetail = snapshot.data!;
                        return Text(_productDetail['name']);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
                trailing: Text(_itemdetails['qty'].toString()),
              ),
            );
          }),
    );
  }

  Widget _bottomContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            width: _deviceWidth! * 0.43,
            child: Center(
                child: Text("LKR 1750",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 19)))),
        SizedBox(
          width: _deviceWidth! * 0.43,
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              foregroundColor: const Color.fromARGB(255, 255, 255, 255),
              backgroundColor: Customcolors().accent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Ready Package',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
        ),
      ],
    );
  }

  TextStyle _orderText() {
    return TextStyle(
        color: Colors.black, fontSize: 15, fontWeight: FontWeight.w500);
  }
}
