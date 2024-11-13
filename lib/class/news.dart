import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:puppymart/services/firebase_service.dart';


String NEWS_COLLECTION = 'News';
class News extends FirebaseService {



  Stream<QuerySnapshot> getNews() {
    return db
        .collection(NEWS_COLLECTION)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<bool> addNews(
      {required String name,
      required String desc,
      required File image}) async {
    try {
      String _newName = name.replaceAll(" ", "-");
      String _newsID =
          Timestamp.now().millisecondsSinceEpoch.toString() + _newName;
      String _imageName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);
      UploadTask _task =
          cloud.ref('images/news/$_imageName').putFile(image);
      return await _task.then((_snapshot) async {
        String _imageLink = await _snapshot.ref.getDownloadURL();
        await db.collection(NEWS_COLLECTION).doc(_newsID).set({
          "newsId": _newsID,
          "name": name,
          "image": _imageLink,
          "description": desc,
          "timestamp": Timestamp.now(),
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }
}