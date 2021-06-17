import 'package:dong/data/entities.dart';
import 'package:dong/di.dart';
import 'package:dong/domain/signup.dart';
import 'package:dong/domain/validation.dart';

class RegisterViewModel {
  SignupUsecase _signupUsecase = Injection.signupUsecase();
  ValidationUseCase _validationUseCase = Injection.validationUseCase();

  void signup(
      User user, String repeatedPass, Function onSucces, Function onError) {
    _validationUseCase.validateRegisteration(user, repeatedPass, () {
      _signupUsecase.signup(user, () {
        onSucces();
      }, (message) {
        onError(message);
      });
    }, (message) {
      onError(message);
    });
  }
}
