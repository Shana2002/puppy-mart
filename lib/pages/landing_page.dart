import 'package:flutter/material.dart';
import 'package:puppymart/pages/loginPage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  double? _deviceHeight, _deviceWidth;


  bool selected = false;
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(children: [
        _backgroundImage(),
        _backgroundDarker(),
        _bottomController(),
      ]),
    );
  }

  Widget _backgroundImage() {
    return Container(
      width: _deviceWidth! * 1,
      height: _deviceHeight! * 1,
      decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assests/images/background.png"))),
    );
  }

  Widget _backgroundDarker() {
    return Container(
      width: _deviceWidth! * 1,
      height: _deviceHeight! * 1,
      color: const Color.fromRGBO(0, 0, 0, 0.4),
    );
  }

  Widget _bottomController() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeIn,
        width: _deviceWidth,
        height: selected ? _deviceHeight! * 0.8 : _deviceHeight! * 0.5,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          color: Color.fromRGBO(8, 7, 5, 1),
        ),
        child: selected ? const Loginpage() : _getStart(),
      ),
    );
  }

  // Getstart Details

  Widget _getStart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [_title(), _description(), _startButton()],
    );
  }

  Widget _title() {
    return const Text(
      "Puppy Mart",
      style: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget _description() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.05),
      child: const Text(
        "Lorem ipsum odor amet, consectetuer adipiscing elit. Habitasse orci maximus metus lobortis justo quis taciti lectus. Nulla elit diam hendrerit sagittis cursus! Turpis id neque tempor consectetur lacus integer libero. Eget turpis incept",
        style: TextStyle(fontSize: 14, color: Colors.white),
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _startButton() {
    return Container(
      width: _deviceWidth! * 0.9,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(186, 45, 11, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            selected = !selected;
          });
        },
        child: const Text(
          "Get Start",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  // Login Form
}
