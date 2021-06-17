import 'package:dong/backend/exposed/failure.dart';

abstract class LoginUser {
  Future<Failure> loginUser({String email, String password});
}
