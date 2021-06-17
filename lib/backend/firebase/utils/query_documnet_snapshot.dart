import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>> _mapify(
    Map<String, dynamic> original, String id) async {
  Map<String, dynamic> data = Map.from(original);
  List<String> keys = data.keys.toList();
  for (String key in keys) {
    if (data[key] is DocumentReference) {
      data[key] = await (data[key] as DocumentReference).mapified;
    }
    if (data[key] is List) {
      List<dynamic> fetchedData = [];
      for (var item in data[key]) {
        var fetched;
        if (item is DocumentReference) {
          fetched = await item.mapified;
        } else {
          fetched = item;
        }
        fetchedData.add(fetched);
      }
      data[key] = fetchedData;
    }
  }
  return data..putIfAbsent("id", () => id);
}

extension MapifyQueryDocumentSnapshot on QueryDocumentSnapshot {
  Future<Map<String, dynamic>> get mapified => _mapify(this.data(), this.id);
}

extension _DocumentMapify on DocumentReference {
  Future<Map<String, dynamic>> get mapified async {
    Map<String, dynamic> data = (await this.get()).data() ?? {};
    return _mapify(data, this.id);
  }
}
