import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dong/backend/firebase/user/get_user.dart';
import 'package:dong/di.dart';

class FirestoreAddSubscriber {
  final FirestoreGetUser getUser;
  final String groupId;

  FirestoreAddSubscriber({this.groupId, this.getUser});
  Future<void> addSubscriber() async {
    DocumentReference group =
        FirebaseFirestore.instance.collection("groups").doc(groupId);
    if (group == null) throw "Group with id $groupId does not exists";
    if (!await getUser.exists)
      throw "User with id ${getUser.userId} does not exist";
    Map<String, dynamic> data = (await group.get()).data();
    if (data['creator'].id != Injection.localDataSource.userId)
      throw "Logged in user is not creator of group";
    if (data['subscribers'].any((e) => e.id == getUser.userId))
      throw "User with id ${getUser.userId} already subscribed";
    if (data['creator'].id == getUser.userId)
      throw "User with id ${getUser.userId} already subscribed";
    data['subscribers'].add(getUser.reference);
    group.update(data);
  }
}
