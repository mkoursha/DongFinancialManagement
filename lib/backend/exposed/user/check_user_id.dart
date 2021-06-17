import 'package:dong/backend/exposed/failure.dart';

abstract class CheckUserId {
  Future<Failure> checkUserId(String userId);
}
