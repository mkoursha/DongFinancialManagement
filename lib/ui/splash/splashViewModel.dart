import 'package:dong/di.dart';

class SplashViewModel {
  void decideNavigation(Function onStart) {
    var isLoggedIn = Injection.isLoggedIn();
    onStart(isLoggedIn);
  }
}
