import 'package:dong/backend/exposed/failure.dart';

abstract class DeleteFactor {
  Future<Failure> deleteFactor(String factorId, String groupId);
}
