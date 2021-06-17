import 'package:dong/data/entities.dart';

abstract class GetUser {
  Future<User> getUser();
  Future<User> userById(String id);
  User userByIdSync(String id);
}
