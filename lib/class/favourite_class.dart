import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puppymart/services/firebase_service.dart';

final String FAVOURITE_COLLECTION = 'favourite';

class FavouriteClass extends FirebaseService {
  void addFavourite(String proId) async {
    DocumentSnapshot query = await db
        .collection(FAVOURITE_COLLECTION)
        .doc(auth.currentUser!.uid)
        .get();
    Map favourite = query.data() as Map<String, dynamic>;
    List fav = favourite['favProducts'];
    int _index = 0;
    bool isfav = false;
    for (var e in fav) {
      if (e == proId) {
        isfav = true;
        break;
      }
      _index++;
    }
    isfav ? fav.removeAt(_index) : fav.add(proId);
    await db.collection('favourite').doc(auth.currentUser!.uid).set({
      'favProducts' : fav,
    });
  }
}
