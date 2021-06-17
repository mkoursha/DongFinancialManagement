import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCreateGroup {
  final String name;
  final String creatorId;
  FirestoreCreateGroup({this.creatorId, this.name});

  Future<void> create() async {
    CollectionReference groups =
        FirebaseFirestore.instance.collection("groups");
    DocumentReference creator =
        FirebaseFirestore.instance.collection("users").doc(creatorId);
    if (creator == null) throw "Creator of group does not exist";
    await groups.add({
      "name": name,
      "creator": creator,
      "subscribers": <DocumentReference>[],
      "factors": <DocumentReference>[],
    });
  }
}
