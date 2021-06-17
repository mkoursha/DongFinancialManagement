import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dong/backend/exposed/group/get_groupes_stream.dart';
import 'package:dong/backend/firebase/group/get_groups.dart';
import 'package:dong/backend/firebase/utils/query_documnet_snapshot.dart';
import 'package:dong/backend/repository/group/utils/from_json.dart';
import 'package:dong/data/entities.dart';
import 'package:dong/di.dart';

extension AddIfNotPresent on List<User> {
  void addIfNotPresent(User user) =>
      this.contains(user) ? null : this.add(user);
  void addAllIfNotPresent(List<User> users) => users.forEach((element) {
        this.addIfNotPresent(element);
      });
}

class GetGroupsStreamImpl extends GetGroupsStream {
  final StreamController<List<Group>> _controller = StreamController();
  var _subscriptionId;
  var _stream;
  List<Group> _current = [];

  void _init() {
    String userId = Injection.localDataSource.userId;
    if (userId == null) return;
    _subscriptionId =
        FirestoreGetGroups().getSnapShot(userId).listen((event) async {
      _controller.sink.add(await _convert(event));
    });
  }

  Future<List<Group>> _convert(List<QueryDocumentSnapshot> data) async {
    List<Map<String, dynamic>> dataConverted = [];
    for (QueryDocumentSnapshot snap in data) {
      dataConverted.add(await snap.mapified);
    }
    _current =
        dataConverted.map<Group>((e) => GroupFromJson.fromJson(e)).toList();
    return _current;
  }

  @override
  Stream<List<Group>> groupsStream() {
    if (_subscriptionId == null) _init();
    _stream = _stream ?? _controller.stream.asBroadcastStream();
    return _stream;
  }

  @override
  List<Group> get currentGroups => _current;

  @override
  List<User> get allUsers {
    List<User> users = [];
    _current.forEach((element) {
      users.addIfNotPresent(element.creator);
      users.addAllIfNotPresent(element.subscribers);
    });
    return users;
  }
}
