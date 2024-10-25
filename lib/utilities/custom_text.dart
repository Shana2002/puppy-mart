import 'package:flutter/material.dart';

class CustomText {
  static Text titleText(String title) {
    return Text(
      title,
      style: const TextStyle(
          color: Color.fromRGBO(0, 0, 0, 1),
          fontWeight: FontWeight.bold,
          fontSize: 25),
    );
  }
}