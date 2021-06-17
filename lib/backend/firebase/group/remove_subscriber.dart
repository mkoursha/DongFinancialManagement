import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dong/di.dart';

class FirestoreRemoveSubscriber {
  final String userId;
  final String groupId;
  FirestoreRemoveSubscriber({this.userId, this.groupId});

  Future<void> removeSubscriber() async {
    DocumentReference group =
        FirebaseFirestore.instance.collection("groups").doc(groupId);
    if (group == null) throw "Group with id $groupId does not exists";
    DocumentReference user =
        FirebaseFirestore.instance.collection("users").doc(userId);
    if (user == null) throw "User with id $userId does not exist";
    Map<String, dynamic> data = (await group.get()).data();
    if (data['creator'].id != Injection.localDataSource.userId)
      throw "Logged in user is not creator of group";
    data['subscribers'].removeWhere((e) => e.id == userId);
    group.update(data);
  }
}
