import 'package:flutter/material.dart';

class DecorationClass {
  static BoxDecoration primaryButton(double _width) {
    return BoxDecoration(
      color: const Color.fromRGBO(186, 45, 11, 1),
      borderRadius: BorderRadius.circular(10),
    );
  }

  static InputDecoration userInputs(double _width,String _hint , String _icon) {
    
    return  InputDecoration(
        hintText: _hint,
        prefixIcon: Icon(
          _getIconByString(_icon),
          color: Colors.white,
        ),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(47, 47, 47, 1))),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)));
  }

  static IconData _getIconByString(String iconName) {
  switch (iconName) {
    case 'email':
      return Icons.email;
    case 'password':
      return Icons.lock;
    case 'person':
      return Icons.person;
    default:
      return Icons.help; 
  }
}
}
