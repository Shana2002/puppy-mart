import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puppymart/services/firebase_service.dart';

String REVIEW_COLLECTION = 'review';

class ReviewClass extends FirebaseService {
  int? oldReview;

  Future<bool> addReview(String proId, String review, int rating) async {
    try {
      List _reviewList = await reviewsList(proId);
      Map reviewMap = {
        "reviewer": auth.currentUser!.uid.toString(),
        "review": review,
        "rating": rating,
        "timestamp": Timestamp.now()
      };
      num _currntRating;
      if (_reviewList.isEmpty) {
        _currntRating = rating;
      } else {
        _currntRating = (oldReview! + rating) / 2;
      }
      _reviewList.add(reviewMap);
      print(_reviewList);
      await db.collection(REVIEW_COLLECTION).doc(proId).set({
        'reviews': _reviewList,
        'total': _currntRating.round(),
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
    if (query.data() == null) {
      return [];
    }
    Map favourite = query.data() as Map<String, dynamic>;
    oldReview = favourite['total'];
    return favourite['reviews'];
  }

  Future<int> reviewsCount(String _proId) async {
    DocumentSnapshot query =
        await db.collection(REVIEW_COLLECTION).doc(_proId).get();
    if (query.data() == null) {
      return 0;
    }
    Map favourite = query.data() as Map<String, dynamic>;
    return oldReview = favourite['total'];
  }
}
