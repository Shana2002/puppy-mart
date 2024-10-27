import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/services/firebase_service.dart';
import 'package:puppymart/utilities/decoration_class.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  double? _deviceHeight, _deviceWidth;
  final Tween<double> _loginShow = Tween<double>(begin: 0.0, end: 1.0);
  bool selectedForm = false;
  FirebaseService? _firebaseService;
  String? _varEmailLogin,
      _varPasswordLogin,
      _varEmailReg,
      _varPasswordReg,
      _varNameReg;

  String? _errorMessage;

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return _loginFormGenerate();
  }

  // Logina form entering Animation with switch login and registerform
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

  // login form
  Widget _loginForm() {
    return SizedBox(
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
            _singUpLink()
          ],
        ),
      ),
    );
  }

  // register form
  Widget _registerForm() {
    return SizedBox(
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
                _nameRegi(),
                SizedBox(
                  height: _deviceHeight! * 0.05,
                ),
                _emailRegi(),
                SizedBox(
                  height: _deviceHeight! * 0.05,
                ),
                _passwordRegi(),
              ],
            ),
            _regisButton(),
            _singUpLink()
          ],
        ),
      ),
    );
  }

  // email for login
  Widget _emailLogin() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
          onSaved: (_value) {
            setState(() {
              _varEmailLogin = _value;
            });
          },
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration:
              DecorationClass.userInputs(_deviceWidth!, "Email", "email"),
          validator: (_value) {
            bool _resualt = _value!.contains(RegExp(
                r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"));
            return _resualt ? null : "Please Enter valid email";
          }),
    );
  }

  // password field for login
  Widget _passwordLogin() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
          onSaved: (_value) {
            setState(() {
              _varPasswordLogin = _value;
            });
          },
          validator: (_value) =>
              _value!.length > 6 ? null : "Enter Valid Password",
          obscureText: true,
          style: const TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: DecorationClass.userInputs(
              _deviceWidth!, "Password", "password")),
    );
  }

  // Login Button
  Widget _loginButton() {
    return Container(
      width: _deviceWidth! * 0.9,
      decoration: DecorationClass.primaryButton(_deviceWidth!),
      child: MaterialButton(
        onPressed: _loginUser,
        child: const Text(
          "Login",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  // Title
  Widget _title() {
    return Column(
      children: [
        const Text(
          "Puppy Mart",
          style: TextStyle(
              color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 20,
        ),
        _errorMesage()
      ],
    );
  }

  Widget _errorMesage() {
    return Text(
      _errorMessage == null ? "" : _errorMessage!,
      style: const TextStyle(color: Colors.red),
    );
  }

  // Link for sign up and login page toggle
  Widget _singUpLink() {
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

  // Register Form fields
  // email for regiser
  Widget _emailRegi() {
    return SizedBox(
        width: _deviceWidth! * 0.80,
        child: TextFormField(
            onSaved: (_value) {
              setState(() {
                _varEmailReg = _value;
              });
            },
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration:
                DecorationClass.userInputs(_deviceWidth!, "Email", "email"),
            validator: (_value) {
              bool _resualt = _value!.contains(RegExp(
                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"));
              return _resualt ? null : "Please Enter valid email";
            }));
  }

// User name feild
  Widget _nameRegi() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
        onSaved: (_value) {
          setState(() {
            _varNameReg = _value;
          });
        },
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: DecorationClass.userInputs(_deviceWidth!, "Name", "person"),
        validator: (_value) =>
            _value!.length > 5 ? null : "Enter Valid Password",
      ),
    );
  }

  // Password Login
  Widget _passwordRegi() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
        onSaved: (_value) {
          setState(() {
            _varPasswordReg = _value;
          });
        },
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration:
            DecorationClass.userInputs(_deviceWidth!, "Password", "password"),
        validator: (_value) =>
            _value!.length > 6 ? null : "Enter Valid Password",
      ),
    );
  }

  Widget _regisButton() {
    return Container(
      width: _deviceWidth! * 0.9,
      decoration: DecorationClass.primaryButton(_deviceWidth!),
      child: MaterialButton(
        onPressed: _registerUser,
        child: const Text(
          "Register",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  void _loginUser() async {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      bool _result = await _firebaseService!
          .loginUser(email: _varEmailLogin!, password: _varPasswordLogin!);
      if (_result) {
        if(_firebaseService!.userName()=='admin@puppymart.com'){
          Navigator.popAndPushNamed(context, 'adminpage');
        }else
        {
          Navigator.popAndPushNamed(context, 'homepage');
        }
        
      } else {
        setState(() {
          _errorMessage = "User Name or Password Wrong";
        });
      }
    }
  }

  void _registerUser() async {
    if (_signupFormKey.currentState!.validate()) {
      _signupFormKey.currentState!.save();
      bool _result = await _firebaseService!.registerUser(
          name: _varNameReg!, email: _varEmailReg!, password: _varPasswordReg!);
      if (_result) {
        setState(() {
          selectedForm = !selectedForm;
        });
      } else {
        _errorMessage = "Something went wrong";
      }
    }
  }
}
