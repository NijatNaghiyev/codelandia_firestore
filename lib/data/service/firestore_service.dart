import 'package:codelandia_firestore/data/models/product_model/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InitFireStore {
  InitFireStore._();

  /// Upload data to firestore for each user
  static Future<void> uploadData(ProductModel productModel) async {
    final firebaseAuth = FirebaseAuth.instance.currentUser!.email;
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('$firebaseAuth').add(productModel.toJson());
  }

  /// Update data from firestore
  static Future<void> updateData(ProductModel productModel, String id) async {
    final firebaseAuth = FirebaseAuth.instance.currentUser!.email;

    final firestore = FirebaseFirestore.instance;

    await firestore.collection('$firebaseAuth').doc(id).update(
          productModel.toJson(),
        );
  }

  /// Delete data from firestore
  static Future<void> deleteData(String id) async {
    final firebaseAuth = FirebaseAuth.instance.currentUser!.email;

    final firestore = FirebaseFirestore.instance;

    await firestore.collection('$firebaseAuth').doc(id).delete();
  }
}
