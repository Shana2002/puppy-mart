import 'package:flutter/material.dart';
import 'package:puppymart/class/favourite_class.dart';

class FavouriteProvider extends ChangeNotifier {
  

  Future<bool> updateFavourite(String productId) async {
    bool isFavourite = false;
    List _favList = await FavouriteClass().favItems();
    for (var e in _favList) {
      if (e == productId) {
        isFavourite = true;
        break;
      }
    }
    notifyListeners();
    return isFavourite;
  }
}
