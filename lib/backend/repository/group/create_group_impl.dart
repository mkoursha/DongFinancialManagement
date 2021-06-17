import 'package:dong/backend/exposed/failure.dart';
import 'package:dong/backend/exposed/group/create_group.dart';
import 'package:dong/backend/firebase/group/create_group.dart';
import 'package:dong/di.dart';

class CreateGroupImpl extends CreateGroup {
  @override
  Future<Failure> createGroup({String name}) async {
    try {
      if (name == null || name.length < 3) throw "Invalid group name";
      await FirestoreCreateGroup(
              creatorId: Injection.localDataSource.userId, name: name)
          .create();
      return null;
    } catch (err) {
      return Failure(message: err.toString());
    }
  }
}
