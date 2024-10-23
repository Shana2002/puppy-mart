import 'package:flutter/material.dart';
import 'package:puppymart/widgets/home_page_app_bar.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  double? _deviceHeight, _deviceWidth;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HomePageAppBar(),
          _dogBanner(),
          SizedBox(
            height: 20,
          ),
          _topSaleContainer("Top Sale"),
          _itemConatiner(),
          _topSaleContainer("Top Offers"),
          _itemConatiner(),
        ],
      ),
    );
  }

  Widget _dogBanner() {
    return Container(
      width: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.20,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage("assests/images/dogBanner.png"))),
    );
  }

  Widget _topSaleContainer(String _name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            _name,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 23),
          ),
          const Text(
            "See More",
            style: TextStyle(color: Color.fromRGBO(186, 45, 11, 1)),
          ),
        ],
      ),
    );
  }

  Widget _itemConatiner() {
    return Container(
      margin: EdgeInsets.only(
          left: _deviceWidth! * 0.05,
          top: _deviceHeight! * 0.02,
          bottom: _deviceHeight! * 0.02),
      // margin: EdgeInsets.symmetric(horizontal: _deviceWidth!*0.05,vertical: _deviceHeight!*0.02),
      height: 200,
      child: ListView(
        // This next line does the trick.
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _item(),
          const SizedBox(
            width: 10,
          ),
          _item(),
          const SizedBox(
            width: 10,
          ),
          _item(),
          const SizedBox(
            width: 10,
          ),
          _item(),
          const SizedBox(
            width: 10,
          ),
          _item(),
          const SizedBox(
            width: 10,
          ),
          _item(),
          const SizedBox(
            width: 10,
          ),
          
        ],
      ),
    );
  }

  Widget _item() {
    return Container(
      width: 160,
      child: Column(
        children: [
          Container(
            width: 160,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage("assests/images/food.png")),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Pedegree 400g",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.star,
                    size: 13,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    size: 13,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    size: 13,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    size: 13,
                    color: Colors.yellow,
                  ),
                  Icon(
                    Icons.star,
                    size: 13,
                    color: Colors.black,
                  ),
                ],
              ),
              Text("1500")
            ],
          )
        ],
      ),
    );
  }
}
