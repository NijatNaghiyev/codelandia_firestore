import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codelandia_firestore/data/models/product_model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final productProvider = StreamProvider.autoDispose<List<ProductModel>>(
  (ref) {
    final firebaseAuth = FirebaseAuth.instance.currentUser!.email;

    final firestore = FirebaseFirestore.instance;

    final data = firestore.collection('$firebaseAuth').snapshots();

    return data.map((event) {
      return event.docs.map((e) {
        return ProductModel.fromJson(e.id, e.data());
      }).toList();
    });
  },
);
