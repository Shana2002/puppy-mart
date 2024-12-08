import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/services/firebase_service.dart';
import 'package:puppymart/utilities/CustomColors.dart';
import 'package:puppymart/utilities/custom_text.dart';
import 'package:puppymart/utilities/decoration_class.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  GlobalKey<FormState> updateKey = GlobalKey<FormState>();
  double? _deviceHeight, _deviceWidth;
  String? _varName, _address1, _address2, _varcity, _mobile;
  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
    assignedValue();
  }

  void assignedValue() {
    _varName = _firebaseService!.currentUser!['name'];
    _address1 = _firebaseService!.currentUser!['address1'];
    _address2 = _firebaseService!.currentUser!['address2'];
    _varcity = _firebaseService!.currentUser!['city'];
    _mobile = _firebaseService!.currentUser!['mobile'];
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Customcolors().secondory,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back)),
        title: Text("Update Profile"),
      ),
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.1),
              child: _inputBoxes())),
    );
  }

  Widget _inputBoxes() {
    return Form(
      key: updateKey,
      child: Container(
        height: _deviceHeight! * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _username(),
            addressLineOne(),
            addressLinetwo(),
            _city(),
            _mobileNo(),
            _updateBtn(),
          ],
        ),
      ),
    );
  }

  Widget _username() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
        initialValue: _varName,
        onSaved: (_value) {
          setState(() {
            _varName = _value;
          });
        },
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        cursorColor: const Color.fromARGB(255, 0, 0, 0),
        decoration: DecorationClass.userInputsUpdate(
            _deviceWidth!, "Name", "User Name"),
        validator: (_value) =>
            _value!.length > 5 ? null : "Enter Valid User Name",
      ),
    );
  }

  Widget addressLineOne() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
        initialValue: _address1,
        onSaved: (_value) {
          setState(() {
            _address1 = _value;
          });
        },
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        cursorColor: const Color.fromARGB(255, 0, 0, 0),
        decoration: DecorationClass.userInputsUpdate(
            _deviceWidth!, "", "Address Line 1"),
        validator: (_value) =>
            _value!.isNotEmpty ? null : "Enter Valid Address",
      ),
    );
  }

  Widget addressLinetwo() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
        initialValue: _address2,
        onSaved: (_value) {
          setState(() {
            _address2 = _value;
          });
        },
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        cursorColor: const Color.fromARGB(255, 0, 0, 0),
        decoration: DecorationClass.userInputsUpdate(
            _deviceWidth!, "", "Address Line 2"),
        validator: (_value) =>
            _value!.isNotEmpty ? null : "Enter Valid Address",
      ),
    );
  }

  Widget _city() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
        initialValue: _varcity,
        onSaved: (_value) {
          setState(() {
            _varcity = _value;
          });
        },
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        cursorColor: const Color.fromARGB(255, 0, 0, 0),
        decoration: DecorationClass.userInputsUpdate(_deviceWidth!, "", "City"),
        validator: (_value) =>
            _value!.isNotEmpty ? null : "Enter Valid Address",
      ),
    );
  }

  Widget _mobileNo() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
        initialValue: _mobile,
        onSaved: (_value) {
          setState(() {
            _mobile = _value;
          });
        },
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        cursorColor: const Color.fromARGB(255, 0, 0, 0),
        decoration:
            DecorationClass.userInputsUpdate(_deviceWidth!, "", "Mobile"),
        validator: (_value) =>
            _value!.length == 10 ? null : "Enter Valid Mobile Number",
      ),
    );
  }

  Widget _updateBtn() {
    return SizedBox(
      width: _deviceWidth! * 0.43,
      child: TextButton(
        onPressed: () {
          updateProfile();
        },
        style: TextButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          backgroundColor: Customcolors().accent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Update Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }

  void updateProfile() async{
    if (updateKey.currentState!.validate()) {
      updateKey.currentState!.save();
      await _firebaseService!.uploadProfile(
          _varName!, _address1!, _address2!, _varcity!, _mobile!);
      Navigator.pop(context);
    }
  }
}
