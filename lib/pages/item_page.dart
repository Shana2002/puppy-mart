import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  double? _deviceHeight, _deviceWidth;

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
            _reviews(),
            _reviewCard(),
            const SizedBox(
              height: 20,
            ),
            _addReview(),
          ],
        ),
      ),
    );
  }

  Widget _descriptionImage() {
    return Container(
      width: _deviceWidth! * 0.9,
      height: _deviceHeight! * 0.4,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage("assests/images/food.png"))),
    );
  }

  Widget _descriptionTitle() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "Pedigree",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _priceConatianer() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "LKR 12500",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            Icon(
              Icons.star,
              size: 25,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              size: 25,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              size: 25,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              size: 25,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              size: 25,
              color: Colors.black,
            ),
          ],
        ),
      ],
    );
  }

  Widget _descriptionDetails() {
    return const Text(
        "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).");
  }

  Widget _reviews() {
    return const Column(
      children: [
        Text(
          "Reviews",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star,
              size: 25,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              size: 25,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              size: 25,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              size: 25,
              color: Colors.yellow,
            ),
            Icon(
              Icons.star,
              size: 25,
              color: Colors.black,
            ),
          ],
        ),
        // _reviewCard()
      ],
    );
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
              onPressed: () {},
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

  Widget _reviewCard() {
    return ListView(
      shrinkWrap: true, // allows ListView to size based on its content
      physics: NeverScrollableScrollPhysics(),
      children: [
        const ListTile(
          leading: Icon(Icons.person),
          title: Text("Channa"),
          subtitle: Text("hi"),
        ),
        const ListTile(
          leading: Icon(Icons.person),
          title: Text("Channa"),
          subtitle: Text("hi"),
        ),
        const ListTile(
          leading: Icon(Icons.person),
          title: Text("Channa"),
          subtitle: Text("hi"),
        ),
      ],
    );
  }

  Widget _addReview() {
    return Container(
      child: SizedBox(
        width: _deviceWidth! * 0.80,
        child: TextFormField(
          style: TextStyle(color: Colors.white),
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
}
