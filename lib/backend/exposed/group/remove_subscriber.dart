import 'package:dong/backend/exposed/failure.dart';

abstract class RemoveSubscriber {
  Future<Failure> removeSubscriber(String subscriberId, String groupId);
}
