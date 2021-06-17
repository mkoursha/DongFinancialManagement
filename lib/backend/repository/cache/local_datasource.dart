import 'package:dong/data/entities.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSource with ChangeNotifier {
  final SharedPreferences sharedPreferences;

  LocalDataSource({this.sharedPreferences});

  Future<bool> setUserId(String userId) async {
    await sharedPreferences.setString("userId", userId);
    notifyListeners();
  }

  Future<bool> removeUserId() async {
    await sharedPreferences.remove("userId");
    notifyListeners();
  }

  String get userId => sharedPreferences.getString("userId");
}
