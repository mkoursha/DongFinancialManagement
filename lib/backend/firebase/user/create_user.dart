import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dong/backend/firebase/user/find_user.dart';

class FirestoreCreateUser {
  final FirestoreFindUser findUser;
  final String name;
  final String lastName;
  final String phoneNumber;

  FirestoreCreateUser({
    this.name,
    this.lastName,
    this.phoneNumber,
    this.findUser,
  });

  Future<DocumentReference> create() async {
    if (await findUser.onlyEmail != null)
      throw "User with email ${findUser.email} already exists";
    return await FirebaseFirestore.instance.collection("users").add({
      "email": findUser.email,
      "password": findUser.password,
      "name": name,
      "lastName": lastName,
      "phoneNumber": phoneNumber,
    });
  }
}
