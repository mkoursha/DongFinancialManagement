import 'package:dong/data/entities.dart';

class Repository {
  bool isLoggedIn() {}

  void signUpUser(User user, Function onSuccess, Function onError) {}

  void logout() {}

  void setUser(User user) {}

  User loggedInUser() {}

  void login(String email, String pass, Function onsuccess, Function onError) {}
}
