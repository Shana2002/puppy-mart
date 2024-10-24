import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/pages/allitems_page.dart';
import 'package:puppymart/pages/cart.dart';
import 'package:puppymart/pages/home_page.dart';
import 'package:puppymart/pages/landing_page.dart';
import 'package:puppymart/services/firebase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetIt.instance.registerSingleton<FirebaseService>(
    FirebaseService() 
  );
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
        'landing': (context) => LandingPage(),
        'homepage': (context) => HomePage(),
        'cart': (context) => Cart(),
      },
    );
  }
}
