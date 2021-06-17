import 'package:dong/backend/exposed/failure.dart';
import 'package:dong/data/entities.dart';
import 'package:flutter/foundation.dart';

abstract class CreateFactor {
  Future<Failure> createFactor({
    DateTime date,
    @required String buyerUserId,
    String description,
    @required List<Good> goods,
    @required String groupId,
  });
}
