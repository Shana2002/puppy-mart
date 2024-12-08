import 'package:flutter/material.dart';
import 'package:puppymart/class/favourite_class.dart';
import 'package:puppymart/providers/favourite_provider.dart';
import 'package:puppymart/utilities/CustomColors.dart';

class FavouriteIcon extends StatefulWidget {
  String productId;
  FavouriteIcon({super.key, required this.productId});

  @override
  State<FavouriteIcon> createState() => _FavouriteIconState();
}

class _FavouriteIconState extends State<FavouriteIcon> {
  bool isFavourite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavourite();
  }

  Future<void> _checkIfFavourite() async {
    // Check if the item is already a favourite
    bool favStatus =
        await FavouriteProvider().updateFavourite(widget.productId);
    if (mounted) {
      setState(() {
        isFavourite = favStatus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: GestureDetector(
        onTap: () async{
          await FavouriteClass().addFavourite(widget.productId);
          _checkIfFavourite();
        },
        child: Container(
            margin: EdgeInsets.only(right: 10, top: 10),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Customcolors().secondory,
                borderRadius: BorderRadius.circular(100)),
            child: Icon(
              Icons.favorite,
              size: 20,
              color: isFavourite
                  ? Colors.red
                  : const Color.fromARGB(186, 90, 92, 90),
            )),
      ),
    );
  }
}

// Align(
    //   alignment: Alignment.topRight,
    //   child: GestureDetector(
    //     onTap: () {
    //       FavouriteClass().addFavourite(widget.productId);
    //     },
    //     child: Container(
    //         margin: EdgeInsets.only(right: 10, top: 10),
    //         padding: EdgeInsets.all(5),
    //         decoration: BoxDecoration(
    //             color: Customcolors().secondory,
    //             borderRadius: BorderRadius.circular(100)),
    //         child: Icon(
    //           Icons.favorite,
    //           size: 20,
    //           color: const Color.fromARGB(186, 90, 92, 90),
    //         )),
    //   ),
    // );
