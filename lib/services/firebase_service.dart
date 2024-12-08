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

  // default image for user first time loging
  final String _defultUserImage =
      "https://media.istockphoto.com/id/1337144146/vector/default-avatar-profile-icon-vector.jpg?s=612x612&w=0&k=20&c=BIbFwuv7FxTWvh5S3vB6bkT0Qv8Vn8N5Ffseq84ClGI=";
  Map? currentUser;
  get db {
    return _db;
  }

  get auth {
    return _auth;
  }

  get cloud {
    return _cloud;
  }

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

  Future<bool> uploadProfilePic(File image) async {
    try {
      String _userId = _auth.currentUser!.uid;
      String _fileName = Timestamp.now().millisecondsSinceEpoch.toString() +
          _auth.currentUser!.email.toString();
      UploadTask _task =
          _cloud.ref('images/users/$_userId/$_fileName').putFile(image);
      return await _task.then((_snapshot) async {
        String _imageLink = await _snapshot.ref.getDownloadURL();
        await _db.collection(USER_COLLECTION).doc(_userId).set({
          "name": currentUser!["name"],
          "email": currentUser!["email"],
          "image": _imageLink,
        });
        currentUser = await getUserData(uid: _userId);
        return true;
      });
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> uploadProfile(String _userName, String _address1,
      String _address2, String _city, String _mobile) async {
    try {
      String _userId = _auth.currentUser!.uid;
      await _db.collection(USER_COLLECTION).doc(_userId).set({
        "name": _userName,
        "email": currentUser!["email"],
        "image": currentUser!["image"],
        "address1": _address1,
        "address2": _address2,
        "city": _city,
        "mobile": _mobile,
      });
      currentUser = await getUserData(uid: _userId);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
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
      String _newName = name.replaceAll(" ", "-");
      String _productId =
          Timestamp.now().millisecondsSinceEpoch.toString() + _newName;
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

  // trail
  Future<List<Map<String, dynamic>>> getDataList() async {
    QuerySnapshot qShot = await _db
        .collection(PRODUCT_COLLECTION) // Replace with your collection name
        .orderBy("timestamp", descending: true)
        .get();

    // Map each document to a Map<String, dynamic> and return as a list
    return qShot.docs.map((doc) {
      return doc.data() as Map<String, dynamic>;
    }).toList();
  }

  Future<Map<String, dynamic>> getProductDetails(String _productId) async {
    DocumentSnapshot query =
        await _db.collection(PRODUCT_COLLECTION).doc(_productId).get();
    return query.data() as Map<String, dynamic>;
  }
}
