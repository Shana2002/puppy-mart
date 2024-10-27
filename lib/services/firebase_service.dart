import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final String USER_COLLECTION = 'users';
final String PRODUCT_COLLECTION = 'products';

class FirebaseService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage _cloud = FirebaseStorage.instance;
  FirebaseFirestore _db = FirebaseFirestore.instance;

  final String _defultUserImage =
      "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=";
  Map? currentUser;

  FirebaseService();

  Future<bool> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_userCredential.user != null) {
        currentUser = await getUserData(uid: _userCredential.user!.uid);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map> getUserData({required String uid}) async {
    DocumentSnapshot _doc =
        await _db.collection(USER_COLLECTION).doc(uid).get();
    return _doc.data() as Map;
  }

  Future<bool> registerUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      UserCredential _userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      String _userId = _userCredential.user!.uid;

      await _db.collection(USER_COLLECTION).doc(_userId).set({
        "name": name,
        "email": email,
        "image": _defultUserImage,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  bool uploadProfilePic(File image) {
    String _userId = _auth.currentUser!.uid;
    String _fileName = Timestamp.now().millisecondsSinceEpoch.toString();
    return true;
  }

  Future<bool> addProduct(
      {required String name,
      required String desc,
      required String brand,
      required String type,
      required num age,
      required num price,
      required File image}) async {
    try {
      String _productId =
          Timestamp.now().millisecondsSinceEpoch.toString() + name;
      String _imageName = Timestamp.now().millisecondsSinceEpoch.toString() +
          p.extension(image.path);
      UploadTask _task =
          _cloud.ref('images/products/$_imageName').putFile(image);
      return await _task.then((_snapshot) async {
        String _imageLink = await _snapshot.ref.getDownloadURL();
        await _db.collection(PRODUCT_COLLECTION).doc(_productId).set({
          "productId": _productId,
          "name": name,
          "image": _imageLink,
          "description": desc,
          "brand": brand,
          "type": type,
          "age": age,
          "price": price,
          "timestamp": Timestamp.now(),
        });
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Stream<QuerySnapshot> getProducts() {
    return _db
        .collection(PRODUCT_COLLECTION)
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  String? userName() {
    return _auth.currentUser!.email;
  }
}
