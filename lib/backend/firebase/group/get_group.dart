import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreGetGroup {
  final String groupId;

  FirestoreGetGroup({this.groupId});

  DocumentReference get reference =>
      FirebaseFirestore.instance.collection("groups").doc(groupId);
  Future<Map<String, dynamic>> get data => reference
      .get()
      .then((value) => value.data()..putIfAbsent("id", () => reference.id));
  Future<bool> get exists => reference.get().then((value) => value.exists);
}
