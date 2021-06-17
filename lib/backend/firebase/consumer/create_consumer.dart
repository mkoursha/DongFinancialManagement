import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dong/backend/firebase/user/get_user.dart';

class FirestoreCreateConsumer {
  final FirestoreGetUser user;
  final double number;

  FirestoreCreateConsumer({
    this.number,
    this.user,
  });

  Future<DocumentReference> get createReference =>
      FirebaseFirestore.instance.collection("consumers").add({
        "uid": user.reference,
        "number": number,
      });
}
