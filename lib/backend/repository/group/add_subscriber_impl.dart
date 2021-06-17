import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dong/backend/exposed/failure.dart';
import 'package:dong/backend/exposed/group/add_subscriber.dart';
import 'package:dong/backend/firebase/group/add_subscriber.dart';
import 'package:dong/backend/firebase/group/get_group.dart';
import 'package:dong/backend/firebase/user/get_user.dart';
import 'package:dong/di.dart';

class AddSubscriberImpl extends AddSubscriber {
  @override
  Future<Failure> addSubscriber(String subscriberId, String groupId) async {
    try {
      await FirestoreAddSubscriber(
        getUser: FirestoreGetUser(userId: subscriberId),
        groupId: groupId,
      ).addSubscriber();
      return null;
    } catch (err) {
      return Failure(message: err.toString());
    }
  }
}
