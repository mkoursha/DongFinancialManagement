import 'package:dong/backend/exposed/failure.dart';

abstract class AddSubscriber {
  Future<Failure> addSubscriber(String subscriberId, String groupId);
}
