import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puppymart/services/firebase_service.dart';

String REVIEW_COLLECTION = 'review';

class ReviewClass extends FirebaseService {
  
  Future<bool> addReview(
      String proId, String review, num rating) async {
    try {
      List _reviewList = await reviewsList(proId);
      Map reviewMap = {
        "reviewer": auth.currentUser!.uid.toString(),
        "review": review,
        "rating": rating,
        "timestamp": Timestamp.now()
      };
      _reviewList.add(reviewMap);

      await db.collection('reviews').doc(proId).set({
        'reviews' : _reviewList, 
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List> reviewsList(String _proId) async {
    DocumentSnapshot query =
        await db.collection(REVIEW_COLLECTION).doc(_proId).get();
    Map favourite = query.data() as Map<String, dynamic>;
    return favourite['reviews'];
  }
}
