import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreFindUser {
  final String email;
  final String password;

  FirestoreFindUser({
    this.email,
    this.password,
  });

  Future<DocumentReference> get onlyEmail => FirebaseFirestore.instance
      .collection("users")
      .where("email", isEqualTo: email)
      .get()
      .then(
        (value) => value.docs.length == 0 ? null : value.docs.first.reference,
      );
  Future<DocumentReference> get user => FirebaseFirestore.instance
      .collection("users")
      .where("email", isEqualTo: email)
      .where("password", isEqualTo: password)
      .get()
      .then(
        (value) => value.docs.length == 0 ? null : value.docs.first.reference,
      );
}
