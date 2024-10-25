import 'package:flutter/material.dart';
import 'package:puppymart/utilities/custom_text.dart';
import 'package:puppymart/utilities/decoration_class.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  double? _deviceHeight, _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          _topBar(),
          SizedBox(
            height: 20,
          ),
          _inputBoxes(),
        ],
      )),
    );
  }

  Widget _topBar() {
    return SizedBox(
      height: _deviceHeight! * 0.05,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back)),
          SizedBox(
            width: 10,
          ),
          CustomText.titleText("Update Profile"),
        ],
      ),
    );
  }

  Widget _inputBoxes() {
    return Column(
      children: [
        _nameRegi(),
      ],
    );
  }

  Widget _nameRegi() {
    return SizedBox(
      width: _deviceWidth! * 0.80,
      child: TextFormField(
        initialValue: "hansaka",
        onSaved: (_value) {
          setState(() {
            
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
}
