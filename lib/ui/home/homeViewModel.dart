import 'package:dong/di.dart';
import 'package:dong/domain/logout.dart';
import 'package:dong/domain/userInfo.dart';

class HomeViewModel {
  LogoutUsecase _logoutUsecase = Injection.logoutUsecase();
  UserInfoUsecase _userInfoUsecase = Injection.userInfoUsecase();

  void logout(Function then) {
    _logoutUsecase.logout(then);
  }

  void showUserInfo(Function info) {
    _userInfoUsecase.loadUserInfo(info);
  }
}
