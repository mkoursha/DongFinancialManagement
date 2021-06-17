import 'package:dong/backend/exposed/failure.dart';
import 'package:dong/backend/exposed/user/login_user.dart';
import 'package:dong/backend/firebase/user/find_user.dart';
import 'package:dong/di.dart';
import 'package:validators/validators.dart';

class LoginUserImpl extends LoginUser {
  @override
  Future<Failure> loginUser({String email, String password}) async {
    try {
      if (!isEmail(email)) throw "Invalid email";
      if (password == null || password.length < 4)
        throw "Password cannot be empty and should be 4 characters long";
      var reference =
          await FirestoreFindUser(email: email, password: password).user;
      if (reference == null)
        throw "User with email $email does not exist or password is wrong";
      await Injection.localDataSource.setUserId(reference.id);
      return null;
    } catch (err) {
      return Failure(message: err.toString());
    }
  }
}
