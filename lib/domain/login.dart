import 'package:dong/data/repository.dart';

class LoginUsecase {
  Repository _repository;

  LoginUsecase(Repository repository) {
    _repository = repository;
  }

  void login(String email, String pass, Function onsuccess, Function onError) {
    _repository.login(email, pass, onsuccess, onError);
  }
}
