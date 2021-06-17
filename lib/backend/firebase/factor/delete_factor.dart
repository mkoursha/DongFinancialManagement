import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dong/backend/firebase/group/get_group.dart';

class FirestoreDeleteFactor {
  final String id;
  final FirestoreGetGroup group;

  FirestoreDeleteFactor({
    this.id,
    this.group,
  });

  Future<void> delete() async {
    await FirebaseFirestore.instance.collection("factors").doc(id).delete();
    Map<String, dynamic> groupData = await group.data;
    groupData['factors'].removeWhere((e) => e.id == id);
    await group.reference.update(groupData);
  }
}
