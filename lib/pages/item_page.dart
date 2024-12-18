import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/class/cart_class.dart';
import 'package:puppymart/class/review_class.dart';
import 'package:puppymart/class/user_class.dart';
import 'package:puppymart/providers/cart_provider.dart';
import 'package:puppymart/widgets/home_page_app_bar.dart';
import 'package:five_pointed_star/five_pointed_star.dart';

class ItemPage extends StatefulWidget {
  final Map product;
  const ItemPage({super.key, required this.product});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  double? _deviceHeight, _deviceWidth;
  CartClass? _cart;
  CartProvider? _cartProvider;
  final GlobalKey<FormState> _addReviewFormKey = GlobalKey<FormState>();
  bool rateStart = false;
  int ratingCount = 4;
  String? rateString;

  @override
  void initState() {
    super.initState();
    _cart = GetIt.instance.get<CartClass>();
    _cartProvider = GetIt.instance.get<CartProvider>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
          child: Column(
            children: [
              _topBar(),
              const SizedBox(
                height: 15,
              ),
              _description(),
              _buttonContainer()
            ],
          ),
        ),
      ),
    );
  }

  Widget _topBar() {
    return SizedBox(
      height: _deviceHeight! * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
          GestureDetector(
              onTap: () {
                Navigator.popAndPushNamed(context, 'cart');
              },
              child: Icon(Icons.shopping_cart)),
        ],
      ),
    );
  }

  Widget _description() {
    return SizedBox(
      height: _deviceHeight! * 0.78,
      child: SingleChildScrollView(
        child: Column(
          children: [
            _descriptionImage(),
            const SizedBox(
              height: 10,
            ),
            _descriptionTitle(),
            const SizedBox(
              height: 10,
            ),
            _priceConatianer(),
            const SizedBox(
              height: 20,
            ),
            _descriptionDetails(),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Reviews",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            _reviews(),
            _reviewsCard(),
            const SizedBox(
              height: 20,
            ),
            _addreviewform()
          ],
        ),
      ),
    );
  }

  Widget _addreviewform() {
    return Form(
      key: _addReviewFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ratingStar(),
          _addReview(),
          const SizedBox(
            height: 10,
          ),
          _addReviewButton()
        ],
      ),
    );
  }

  Widget _descriptionImage() {
    return Container(
      width: _deviceWidth! * 0.9,
      height: _deviceHeight! * 0.4,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain,
              image: NetworkImage(widget.product['image']))),
    );
  }

  Widget _descriptionTitle() {
    return SizedBox(
      width: _deviceWidth! * 0.9,
      child: Text(
        widget.product["name"],
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _ratingStar() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth! * 0.27, vertical: _deviceHeight! * 0.01),
      child: Center(
        child: FivePointedStar(
          count: 5,
          gap: 4,
          defaultSelectedCount: 4,
          selectedColor: Colors.yellow,
          onChange: (_count) {
            ratingCount = _count;
          },
        ),
      ),
    );
  }

  Widget _priceConatianer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "LKR ${widget.product['price']}",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        _reviews()
      ],
    );
  }

  Widget _descriptionDetails() {
    return Text(widget.product['description']);
  }

  Widget _reviews() {
    return FutureBuilder(
        future:
            ReviewClass().reviewsCount(widget.product['productId'].toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int currentRate = snapshot.hasData ? snapshot.data! : 4;
            return FivePointedStar(
              count: 5,
              gap: 4,
              defaultSelectedCount: currentRate,
              selectedColor: Colors.yellow,
              disabled: true,
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget _buttonContainer() {
    return SizedBox(
      height: _deviceHeight! * 0.07,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: _deviceWidth! * 0.43,
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Add To Favourite',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
          SizedBox(
            width: _deviceWidth! * 0.43,
            child: TextButton(
              onPressed: () {
                _cart!.addTocart(widget.product['productId'].toString(), 1,
                    widget.product['price']);
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                backgroundColor: const Color.fromARGB(255, 255, 83, 83),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Add To Cart',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _reviewsCard() {
    return FutureBuilder(
      future: ReviewClass().reviewsList(widget.product['productId']),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List reviewsList = snapshot.data;
          return Container(
              width: _deviceWidth! * 0.8,
              height: _deviceHeight! * 0.3,
              child: ListView.builder(
                  itemCount: reviewsList.length > 2 ? 2 : reviewsList.length,
                  itemBuilder: (context, _index) {
                    Map reviewList = reviewsList[_index];
                    return Container(
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: FutureBuilder(
                            future: UserClass()
                                .getUserName(reviewList['reviewer'].toString()),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                Map userDetails = snapshot.data!;
                                return Text(userDetails['name']);
                              } else {
                                return Text("No user found");
                              }
                            }),
                        subtitle: Text(reviewList['review'].toString()),
                      ),
                    );
                  }));
          // List reviewsList = snapshot.data;
          // return ListView.builder(
          //     itemCount: reviewsList.length,
          //     itemBuilder: (context, index) {
          //       Map reviewList = reviewsList[index];
          //       return ListTile(
          //         leading: Icon(Icons.person),
          //         title: Text(),
          //         subtitle: Text(reviewList['review'].toString()),
          //       );
          //     });
        } else {
          return Text("data1");
        }
      },
    );
  }

  Widget _addReview() {
    return Container(
      child: SizedBox(
        width: _deviceWidth! * 0.80,
        child: TextFormField(
          onChanged: (_value) {
            rateString = _value;
          },
          style: TextStyle(color: Colors.black),
          cursorColor: Colors.white,
          decoration: const InputDecoration(
              hintText: "Add Review",
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromRGBO(47, 47, 47, 1))),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white))),
        ),
      ),
    );
  }

  Widget _addReviewButton() {
    return SizedBox(
      width: _deviceWidth! * 0.43,
      child: TextButton(
        onPressed: () {
          addReview();
        },
        style: TextButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          backgroundColor: const Color.fromARGB(255, 86, 83, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Add Review',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }

  void addReview() async {
    await ReviewClass().addReview(
        widget.product['productId'].toString(), rateString!, ratingCount);
    setState(() {
      rateString = "";
    });
  }
}
