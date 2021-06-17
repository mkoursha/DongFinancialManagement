import 'package:dong/backend/exposed/factor/delete_factor.dart';
import 'package:dong/backend/exposed/failure.dart';
import 'package:dong/backend/firebase/factor/delete_factor.dart';
import 'package:dong/backend/firebase/group/get_group.dart';

class DeleteFactorImpl extends DeleteFactor {
  @override
  Future<Failure> deleteFactor(String factorId, String groupId) async {
    try {
      await FirestoreDeleteFactor(
        group: FirestoreGetGroup(groupId: groupId),
        id: factorId,
      ).delete();
      return null;
    } catch (err) {
      return Failure(message: err.toString());
    }
  }
}
