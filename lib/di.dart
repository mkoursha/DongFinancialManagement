import 'package:dong/backend/exposed/factor/create_factor.dart';
import 'package:dong/backend/exposed/factor/delete_factor.dart';
import 'package:dong/backend/exposed/group/add_subscriber.dart';
import 'package:dong/backend/exposed/group/create_group.dart';
import 'package:dong/backend/exposed/group/get_groupes_stream.dart';
import 'package:dong/backend/exposed/group/remove_subscriber.dart';
import 'package:dong/backend/exposed/user/check_user_id.dart';
import 'package:dong/backend/exposed/user/get_user.dart';
import 'package:dong/backend/exposed/user/login_user.dart';
import 'package:dong/backend/exposed/user/register_user.dart';
import 'package:dong/backend/repository/cache/local_datasource.dart';
import 'package:dong/backend/repository/factor/create_factor_impl.dart';
import 'package:dong/backend/repository/factor/delete_factor_impl.dart';
import 'package:dong/backend/repository/group/add_subscriber_impl.dart';
import 'package:dong/backend/repository/group/create_group_impl.dart';
import 'package:dong/backend/repository/group/get_groupes_stream_impl.dart';
import 'package:dong/backend/repository/group/remove_subscriber_impl.dart';
import 'package:dong/backend/repository/user/check_user_id_impl.dart';
import 'package:dong/backend/repository/user/get_user_impl.dart';
import 'package:dong/backend/repository/user/login_user_impl.dart';
import 'package:dong/backend/repository/user/register_user_impl.dart';
import 'package:dong/data/repository.dart';
import 'package:dong/data/repossitoryImpl.dart';
import 'package:dong/domain/login.dart';
import 'package:dong/domain/logout.dart';
import 'package:dong/domain/signup.dart';
import 'package:dong/domain/userInfo.dart';
import 'package:dong/domain/validation.dart';
import 'package:dong/ui/state/groups_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Injection {
  static LocalDataSource localDataSource;

  static LoginUser loginUser;
  static RegisterUser registerUser;
  static GetUser getUser;
  static CreateFactor createFactor;
  static DeleteFactor deleteFactor;
  static AddSubscriber addSubscriber;
  static RemoveSubscriber removeSubscriber;
  static GetGroupsStream getGroups;
  static CreateGroup createGroup;
  static CheckUserId checkUserId;

  static GroupsState groupsState;

  Future<void> init() async {
    await Firebase.initializeApp();
    localDataSource = LocalDataSource(
        sharedPreferences: await SharedPreferences.getInstance());
    loginUser = LoginUserImpl();
    registerUser = RegisterUserImpl();
    getUser = GetUserImpl();
    if (localDataSource.userId != null) {
      _repository.setUser(await getUser.getUser());
    }
    createFactor = CreateFactorImpl();
    deleteFactor = DeleteFactorImpl();
    addSubscriber = AddSubscriberImpl();
    removeSubscriber = RemoveSubscriberImpl();
    getGroups = GetGroupsStreamImpl();
    createGroup = CreateGroupImpl();
    checkUserId = CheckUserIdImpl();

    groupsState = GroupsState(getGroups);
  }

  static Repository _repository = RepositoryImpl();
  static Repository get repository => _repository;

  static ValidationUseCase validationUseCase() {
    return ValidationUseCase(_repository);
  }

  static SignupUsecase signupUsecase() {
    return SignupUsecase(_repository);
  }

  static LoginUsecase loginUsecase() {
    return LoginUsecase(_repository);
  }

  static LogoutUsecase logoutUsecase() {
    return LogoutUsecase(_repository);
  }

  static bool isLoggedIn() {
    return _repository.isLoggedIn();
  }

  static UserInfoUsecase userInfoUsecase() {
    return UserInfoUsecase(_repository);
  }
}
