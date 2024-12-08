import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puppymart/services/firebase_service.dart';

final String FAVOURITE_COLLECTION = 'favourite';

class FavouriteClass extends FirebaseService {
  Future<void> addFavourite(String proId) async {
    List favItem = await favItems();
    int _index = 0;
    bool isfav = false;
    for (var e in favItem) {
      if (e == proId) {
        isfav = true;
        break;
      }
      _index++;
    }
    isfav ? favItem.removeAt(_index) : favItem.add(proId);
    await db.collection('favourite').doc(auth.currentUser!.uid).set({
      'favProducts': favItem,
    });
  }

  Future<List> favItems() async {
    DocumentSnapshot query = await db
        .collection(FAVOURITE_COLLECTION)
        .doc(auth.currentUser!.uid)
        .get();
    if (query.data() != null) {
      Map favourite = query.data() as Map<String, dynamic>;
      return favourite['favProducts'] ?? [];
    } else {
      return [];
    }
  }
}
