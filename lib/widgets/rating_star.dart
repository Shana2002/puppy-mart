import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
  final double size;
  const RatingStar({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.star,
          size: size,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          size: size,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          size: size,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          size: size,
          color: Colors.yellow,
        ),
        Icon(
          Icons.star,
          size: size,
          color: Colors.black,
        ),
      ],
    );
  }
}
