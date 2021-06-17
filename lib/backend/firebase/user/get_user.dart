import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreGetUser {
  final String userId;

  FirestoreGetUser({this.userId});

  DocumentReference get reference =>
      FirebaseFirestore.instance.collection("users").doc(userId);
  Future<Map<String, dynamic>> get data => reference
      .get()
      .then((value) => value.data()..putIfAbsent("id", () => reference.id));
  Future<bool> get exists => reference.get().then((value) => value.exists);
}
