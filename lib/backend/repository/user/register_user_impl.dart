import 'package:dong/backend/exposed/failure.dart';
import 'package:dong/backend/exposed/user/register_user.dart';
import 'package:dong/backend/firebase/user/create_user.dart';
import 'package:dong/backend/firebase/user/find_user.dart';
import 'package:dong/di.dart';
import 'package:validators/validators.dart';

class RegisterUserImpl extends RegisterUser {
  @override
  Future<Failure> registerUser({
    String name,
    String lastName,
    String password,
    String email,
    String phoneNumber,
  }) async {
    try {
      if (!isEmail(email)) throw "Email is invalid";
      if (password == null || password.length < 4)
        throw "Password cannot be empty and should be 4 characters long";
      var ref = await FirestoreCreateUser(
        findUser: FirestoreFindUser(email: email, password: password),
        lastName: lastName ?? "",
        name: name ?? "",
        phoneNumber: phoneNumber ?? "",
      ).create();
      await Injection.localDataSource.setUserId(ref.id);
      return null;
    } catch (err) {
      return Failure(message: err.toString());
    }
  }
}
