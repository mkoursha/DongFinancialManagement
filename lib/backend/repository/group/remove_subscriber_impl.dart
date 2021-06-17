import 'package:dong/backend/exposed/failure.dart';
import 'package:dong/backend/exposed/group/remove_subscriber.dart';
import 'package:dong/backend/firebase/group/get_group.dart';
import 'package:dong/backend/firebase/group/remove_subscriber.dart';

class RemoveSubscriberImpl extends RemoveSubscriber {
  @override
  Future<Failure> removeSubscriber(String subscriberId, String groupId) async {
    try {
      await FirestoreRemoveSubscriber(
        userId: subscriberId,
        groupId: groupId,
      ).removeSubscriber();
      return null;
    } catch (err) {
      return Failure(message: err.toString());
    }
  }
}
