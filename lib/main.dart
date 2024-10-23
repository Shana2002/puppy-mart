import 'package:flutter/material.dart';
import 'package:puppymart/pages/allitems_page.dart';
import 'package:puppymart/pages/cart.dart';
import 'package:puppymart/pages/home_page.dart';
import 'package:puppymart/pages/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Puppy Mart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      initialRoute: 'landing',
      routes: {
        'landing' : (context) => LandingPage(),
        'homepage' : (context) => HomePage(),
        'cart' : (context) => Cart(),
      },
    );
  }
}
