import 'package:dong/data/entities.dart';
import 'package:dong/data/repository.dart';
import 'package:dong/di.dart';

class RepositoryImpl implements Repository {
  User _loggedInUser;

  @override
  bool isLoggedIn() {
    return Injection.localDataSource.userId != null;
  }

  @override
  User loggedInUser() {
    return _loggedInUser;
  }

  void setUser(User user) {
    _loggedInUser = user;
  }

  bool _loginInProgress = false;
  @override
  void login(String email, String pass, Function onsuccess, Function onError) {
    if (_loginInProgress) return;
    Injection.loginUser
        .loginUser(
      email: email,
      password: pass,
    )
        .then((value) async {
      if (value != null)
        onError(value.message);
      else {
        _loggedInUser = await Injection.getUser.getUser();
        onsuccess();
      }
      _loginInProgress = false;
    });
    _loginInProgress = true;
  }

  @override
  void logout() {
    _loggedInUser = null;
    Injection.localDataSource.removeUserId();
  }

  bool _signUpInProgress = false;
  @override
  void signUpUser(User user, Function onSuccess, Function onError) {
    if (_signUpInProgress) return;
    Injection.registerUser
        .registerUser(
      email: user.getEmail(),
      lastName: user.lastName,
      name: user.getName(),
      password: user.getPassWord(),
      phoneNumber: user.phoneNumber,
    )
        .then((value) async {
      if (value != null)
        onError(value.message);
      else {
        _loggedInUser = await Injection.getUser.getUser();
        onSuccess();
      }
      _signUpInProgress = false;
    });

    _signUpInProgress = true;
  }
}
