import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puppymart/services/firebase_service.dart';

class UserClass extends FirebaseService {
  Future<Map> getUserName(String _userId) async {
    DocumentSnapshot query =
        await db.collection(USER_COLLECTION).doc(_userId).get();
    Map userMap = query.data() as Map<String, dynamic>;
    return userMap;
  }
}
