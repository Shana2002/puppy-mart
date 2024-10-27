import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:puppymart/utilities/capitalize_text.dart';
import 'package:puppymart/services/firebase_service.dart';
import 'package:puppymart/utilities/decoration_class.dart';
import 'package:file_picker/file_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double? _deviceHeight, _deviceWidth;

  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: _deviceHeight! * 0.03, horizontal: _deviceWidth! * 0.05),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _profileImage(),
            const SizedBox(
              height: 10,
            ),
            _name(),
            const SizedBox(
              height: 30,
            ),
            _orderHistory(),
            const SizedBox(
              height: 10,
            ),
            _updateProfile(),
            const SizedBox(
              height: 10,
            ),
            _changePassword(),
            const SizedBox(
              height: 60,
            ),
            _LogOut(),
          ],
        ),
      ),
    );
  }

  Widget _profileImage() {
    return Container(
      width: _deviceHeight! * 0.20,
      height: _deviceHeight! * 0.20,
      child: Stack(
        children: [
          Container(
            width: _deviceHeight! * 0.20,
            height: _deviceHeight! * 0.20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      _firebaseService!.currentUser!["image"].toString())),
            ),
          ),
          Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: () {
                  _uploadProfilePic();
                },
                child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(221, 95, 95, 95),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      size: 30,
                      color: Colors.white,
                    )),
              ))
        ],
      ),
    );
  }

  Widget _name() {
    return Text(
      CapitalizeText(text: _firebaseService!.currentUser!["name"]).capitalize(),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _changePassword() {
    return SizedBox(
      width: _deviceWidth! * 0.9,
      child: TextButton(
        onPressed: () {
          // Button pressed action
        },
        style: DecorationClass.secondory,
        child: const Text(
          'Change Password',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }

  Widget _updateProfile() {
    return SizedBox(
      width: _deviceWidth! * 0.9,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, 'updateprofile');
        },
        style: DecorationClass.secondory,
        child: const Text(
          'Update Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }

  Widget _orderHistory() {
    return SizedBox(
      width: _deviceWidth! * 0.9,
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, 'orderhistory');
        },
        style: DecorationClass.secondory,
        child: const Text(
          'Order History',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }

  Widget _LogOut() {
    return Container(
      width: _deviceWidth! * 0.9,
      child: TextButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, 'landing');
        },
        style: TextButton.styleFrom(
          foregroundColor: const Color.fromARGB(255, 255, 255, 255),
          backgroundColor: const Color.fromARGB(255, 255, 64, 64),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          'Log Out',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ),
    );
  }

  _uploadProfilePic() async {
    FilePickerResult? _result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    File _image = File(_result!.files.first.path!);
  }
}
