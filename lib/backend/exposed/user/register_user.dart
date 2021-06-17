import 'package:dong/backend/exposed/failure.dart';
import 'package:dong/data/entities.dart';

abstract class RegisterUser {
  Future<Failure> registerUser({
    String name,
    String lastName,
    String password,
    String email,
    String phoneNumber,
  });
}
