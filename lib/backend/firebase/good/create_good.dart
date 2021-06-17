import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dong/backend/firebase/consumer/create_consumer.dart';
import 'package:dong/backend/firebase/user/get_user.dart';

class FirestoreCreateGood {
  final String name;
  final double unitPrice;
  final double number;
  final Map<String, double> consumers;

  FirestoreCreateGood({
    this.name,
    this.consumers,
    this.number,
    this.unitPrice,
  });

  Future<DocumentReference> createGood() async {
    List<DocumentReference> refConsumers = [];
    List<String> users = consumers.keys.toList();
    for (String user in users) {
      DocumentReference reference = await FirestoreCreateConsumer(
              number: consumers[user], user: FirestoreGetUser(userId: user))
          .createReference;
      refConsumers.add(reference);
    }

    return await FirebaseFirestore.instance.collection("goods").add({
      "name": name,
      "unitPrice": unitPrice,
      "number": number,
      "consumers": refConsumers,
    });
  }
}
