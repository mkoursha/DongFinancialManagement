import 'package:dong/di.dart';
import 'package:dong/domain/login.dart';

class LoginViewModel {
  LoginUsecase _loginUsecase = Injection.loginUsecase();

  void login(String email, String pass, Function onSuccess, Function onError) {
    _loginUsecase.login(email, pass, onSuccess, onError);
  }
}
