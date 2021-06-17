import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dong/backend/firebase/good/create_good.dart';
import 'package:dong/backend/firebase/group/get_group.dart';
import 'package:dong/backend/firebase/user/get_user.dart';

class FirestoreCreateFactor {
  final DateTime dateTime;
  final FirestoreGetUser buyer;
  final List<FirestoreCreateGood> goods;
  final FirestoreGetGroup group;
  final String description;
  final String image;

  FirestoreCreateFactor({
    this.buyer,
    this.dateTime,
    this.description,
    this.goods,
    this.image,
    this.group,
  });

  Future<DocumentReference> create() async {
    List<DocumentReference> refGoods = [];
    for (FirestoreCreateGood good in goods) {
      refGoods.add(await good.createGood());
    }
    if (!await buyer.exists) throw "Buyer does not exist";
    DocumentReference ref =
        await FirebaseFirestore.instance.collection("factors").add({
      "dateTime": dateTime?.toString(),
      "buyer": buyer.reference,
      "goods": refGoods,
      "description": description,
      "image": image,
    });
    Map<String, dynamic> groupData = await group.data;
    groupData['factors'].add(ref);
    await group.reference.update(groupData);
    return ref;
  }
}
