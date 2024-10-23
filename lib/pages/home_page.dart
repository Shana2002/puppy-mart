import 'package:flutter/material.dart';
import 'package:puppymart/pages/allitems_page.dart';
import 'package:puppymart/pages/explore_page.dart';
import 'package:puppymart/pages/favourite_page.dart';
import 'package:puppymart/pages/news_page.dart';
import 'package:puppymart/pages/profile_page.dart';
import 'package:puppymart/widgets/home_page_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? _deviceHeight, _deviceWidth;
  int _currntSelected = 2;

  final List<Widget> _pages = [
    NewsPage(),
    AllitemsPage(),
    ExplorePage(),
    FavouritePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(child: _pages[_currntSelected]),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
        unselectedItemColor: Color.fromARGB(255, 190, 190, 190),
        currentIndex: _currntSelected,
        onTap: (_index) {
          setState(() {
            _currntSelected = _index;
          });
        },
        backgroundColor: Color.fromRGBO(186, 45, 11, 1),
        elevation: 5,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 25,
        fixedColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(label: "news", icon: Icon(Icons.newspaper)),
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "Explore", icon: Icon(Icons.explore)),
          BottomNavigationBarItem(
              label: "Favourite", icon: Icon(Icons.favorite)),
          BottomNavigationBarItem(
              label: "Profile", icon: Icon(Icons.person_outline_rounded)),
        ]);
  }
}
