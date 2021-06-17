import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreGetGroups {
  Stream<List<QueryDocumentSnapshot>> getSnapShot(String userId) =>
      FirebaseFirestore.instance
          .collection("groups")
          .snapshots(includeMetadataChanges: true)
          .map((event) => event.docs)
          .map(
            (event) => event
                .where((element) =>
                    element.data()['creator']?.id == userId ||
                    (element
                            .data()['subscribers']
                            ?.any((u) => u.id == userId) ??
                        false))
                .toList(),
          );
}
