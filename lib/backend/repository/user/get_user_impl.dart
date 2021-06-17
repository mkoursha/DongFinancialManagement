import 'package:dong/backend/exposed/user/get_user.dart';
import 'package:dong/backend/firebase/user/get_user.dart';
import 'package:dong/backend/repository/user/utils/from_json.dart';
import 'package:dong/data/entities.dart';
import 'package:dong/di.dart';

class GetUserImpl extends GetUser {
  Map<String, User> cached = {};
  @override
  Future<User> getUser() async {
    try {
      if (Injection.localDataSource.userId == null) return null;
      var data =
          await FirestoreGetUser(userId: Injection.localDataSource.userId).data;
      return UserFromJson.fromJson(data);
    } catch (err) {
      print("User get : $err");
      return null;
    }
  }

  @override
  Future<User> userById(String id) async {
    if (cached[id] == null) {
      cached[id] =
          UserFromJson.fromJson(await FirestoreGetUser(userId: id).data);
    }
    return cached[id];
  }

  @override
  User userByIdSync(String id) => cached[id];
}
