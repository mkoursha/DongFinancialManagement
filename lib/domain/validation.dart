import 'package:dong/data/entities.dart';
import 'package:dong/data/repository.dart';

class ValidationUseCase {
  Repository _repository;

  ValidationUseCase(Repository repository) {
    _repository = repository;
  }

  void validateRegisteration(
      User user, String repeatedPass, Function onSuccess, Function onError) {
    if (user.getEmail().isNotEmpty &&
        user.getPassWord().isNotEmpty &&
        repeatedPass.isNotEmpty &&
        user.phoneNumber.isNotEmpty) {
      if (user.getPassWord() != repeatedPass) {
        onError('Password fields should match');
      } else {
        onSuccess();
      }
    } else {
      onError('Please complete your info');
    }
  }
}
