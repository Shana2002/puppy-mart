import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/pages/add_news.dart';
import 'package:puppymart/pages/add_product.dart';
import 'package:puppymart/pages/admin_home.dart';
import 'package:puppymart/pages/cart.dart';
import 'package:puppymart/pages/home_page.dart';
import 'package:puppymart/pages/landing_page.dart';
import 'package:puppymart/pages/order_history.dart';
import 'package:puppymart/pages/update_profile.dart';
import 'package:puppymart/services/firebase_service.dart';
import 'package:puppymart/utilities/CustomColors.dart';

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
        scaffoldBackgroundColor: Customcolors().background,
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed(seedColor: Customcolors().accent),
        useMaterial3: true,
      ),
      initialRoute: 'landing',
      routes: {
        'landing': (context) => const LandingPage(),
        'homepage': (context) => const HomePage(),
        'cart': (context) => const Cart(),
        'orderhistory': (context) => const OrderHistory(),
        'updateprofile': (context) => const UpdateProfile(),
        'adminpage' : (context) => const AdminHome(),
        'add_product' : (context) => const AddProduct(),
        'add_news' : (context) => const AddNews(),
       },
    );
  }
}
