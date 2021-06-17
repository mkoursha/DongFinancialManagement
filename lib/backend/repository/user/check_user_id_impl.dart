import 'package:dong/backend/exposed/failure.dart';
import 'package:dong/backend/exposed/user/check_user_id.dart';
import 'package:dong/backend/firebase/user/get_user.dart';

class CheckUserIdImpl extends CheckUserId {
  @override
  Future<Failure> checkUserId(String userId) async {
    try {
      if (await FirestoreGetUser(userId: userId).exists) return null;
      throw "User with id $userId does not exist";
    } catch (err) {
      return Failure(message: err.toString());
    }
  }
}
