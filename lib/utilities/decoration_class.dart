import 'package:flutter/material.dart';
import 'package:puppymart/utilities/CustomColors.dart';

class DecorationClass {
  static BoxDecoration primaryButton(double _width) {
    return BoxDecoration(
      color: Customcolors().primary,
      borderRadius: BorderRadius.circular(10),
    );
  }

  static ButtonStyle secondory = TextButton.styleFrom(
    foregroundColor: const Color.fromARGB(255, 0, 0, 0),
    backgroundColor: const Color.fromARGB(94, 156, 156, 156),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  static InputDecoration userInputs(double _width, String _hint, String _icon) {
    return InputDecoration(
        hintText: _hint,
        prefixIcon: Icon(
          _getIconByString(_icon),
          color: Colors.white,
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Customcolors().accent)),
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

  static InputDecoration inputProduct(String _name) {
    return InputDecoration(
      labelText: _name,
      border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(47, 47, 47, 1))),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Customcolors().accent)));
  }
}
