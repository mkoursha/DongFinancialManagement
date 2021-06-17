import 'package:dong/backend/exposed/failure.dart';
import 'package:flutter/foundation.dart';

abstract class CreateGroup {
  Future<Failure> createGroup({@required String name});
}
