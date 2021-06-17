import 'package:dong/backend/exposed/factor/create_factor.dart';
import 'package:dong/backend/firebase/factor/create_factor.dart';
import 'package:dong/backend/firebase/good/create_good.dart';
import 'package:dong/backend/firebase/group/get_group.dart';
import 'package:dong/backend/firebase/user/get_user.dart';
import 'package:dong/data/entities.dart';
import 'package:dong/backend/exposed/failure.dart';

class CreateFactorImpl extends CreateFactor {
  @override
  Future<Failure> createFactor({
    DateTime date,
    String buyerUserId,
    String description,
    String groupId,
    List<Good> goods,
  }) async {
    try {
      await FirestoreCreateFactor(
        buyer: FirestoreGetUser(userId: buyerUserId),
        dateTime: date ?? DateTime.now(),
        description: description ?? "",
        goods: goods
                ?.map<FirestoreCreateGood>((e) => FirestoreCreateGood(
                      consumers: e.consumers.asMap().map<String, double>(
                          (key, value) =>
                              MapEntry(value.user.id, value.number)),
                      number: e.number,
                      name: e.name,
                      unitPrice: e.unitPrice,
                    ))
                ?.toList() ??
            [],
        group: FirestoreGetGroup(groupId: groupId),
        image: "",
      ).create();
      return null;
    } catch (err) {
      return Failure(message: err.toString());
    }
  }
}
