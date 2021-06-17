import 'package:dong/data/entities.dart';
import 'package:dong/data/repository.dart';

class SignupUsecase {
  Repository _repository;

  SignupUsecase(Repository repository) {
    _repository = repository;
  }

  void signup(User user, Function onSuccess, Function onError) {
    _repository.signUpUser(user, onSuccess, onError);
  }
}
