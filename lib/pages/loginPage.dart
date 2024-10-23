import 'package:flutter/material.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  double? _deviceHeight, _deviceWidth;
  final Tween<double> _loginShow = Tween<double>(begin: 0.0, end: 1.0);
  bool selectedForm = false;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return _loginFormGenerate();
  }

  Widget _loginFormGenerate() {
    return TweenAnimationBuilder(
        tween: _loginShow,
        duration: const Duration(seconds: 1),
        builder: (_context, _scale, _child) {
          return Transform.scale(
            scale: _scale,
            child: _child,
          );
        },
        child: selectedForm ? _registerForm() : _loginForm());
  }

  Widget _loginForm() {
    return Container(
      height: _deviceHeight! * 8.0,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _title(),
            Column(
              children: [
                _emailLogin(),
                SizedBox(
                  height: _deviceHeight! * 0.05,
                ),
                _passwordLogin(),
              ],
            ),
            _loginButton(),
            _SingUpLink()
          ],
        ),
      ),
    );
  }

  Widget _registerForm() {
    return Container(
      height: _deviceHeight! * 8.0,
      child: Form(
        key: _signupFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _title(),
            Column(
              children: [
                _NameRegi(),
                SizedBox(
                  height: _deviceHeight! * 0.05,
                ),
                _emailRegi(),
                SizedBox(
                  height: _deviceHeight! * 0.05,
                ),
                _passwordLogin(),
              ],
            ),
            _regisButton(),
            _SingUpLink()
          ],
        ),
      ),
    );
  }

  Widget _emailLogin() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
            hintText: "Email",
            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(47, 47, 47, 1))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }

  Widget _passwordLogin() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
            hintText: "Password",
            prefixIcon: Icon(
              Icons.key,
              color: Colors.white,
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(47, 47, 47, 1))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      width: _deviceWidth! * 0.9,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(186, 45, 11, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            selectedForm = !selectedForm;
          });
        },
        child: const Text(
          "Login",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  Widget _title() {
    return const Text(
      "Puppy Mart",
      style: TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget _SingUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          selectedForm ? "Already Registerd ." : "Havent register yet ?",
          style: const TextStyle(color: Colors.white, fontSize: 13),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(
            onTap: () {
              setState(() {
                selectedForm = !selectedForm;
              });
            },
            child: Text(
              selectedForm ? "Login Here" : "Register here",
              style: const TextStyle(
                  color: Color.fromRGBO(186, 45, 11, 1), fontSize: 13),
            ))
      ],
    );
  }

  // Register Form
  Widget _emailRegi() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
            hintText: "Email",
            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(47, 47, 47, 1))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }

  Widget _NameRegi() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
            hintText: "Email",
            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(47, 47, 47, 1))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }

  Widget _passwordRegi() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
            hintText: "Password",
            prefixIcon: Icon(
              Icons.key,
              color: Colors.white,
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromRGBO(47, 47, 47, 1))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white))),
      ),
    );
  }

  Widget _regisButton() {
    return Container(
      width: _deviceWidth! * 0.9,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(186, 45, 11, 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: MaterialButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, 'homepage');
        },
        child: const Text(
          "Register",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
