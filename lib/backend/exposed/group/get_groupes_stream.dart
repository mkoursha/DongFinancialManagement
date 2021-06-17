import 'package:dong/data/entities.dart';

abstract class GetGroupsStream {
  List<Group> get currentGroups;
  List<User> get allUsers;
  Stream<List<Group>> groupsStream();
}
