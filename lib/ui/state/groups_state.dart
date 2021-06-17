import 'package:dong/backend/exposed/group/get_groupes_stream.dart';
import 'package:dong/data/entities.dart';
import 'package:flutter/foundation.dart';

class GroupsState extends ChangeNotifier {
  List<Group> groups = [];

  GroupsState(GetGroupsStream stream) {
    stream.groupsStream().listen((event) {
      groups = event;
      notifyListeners();
    });
  }
}
