import 'package:dong/backend/repository/cache/local_datasource.dart';
import 'package:dong/di.dart';
import 'package:dong/ui/home/homescreen.dart';
import 'package:dong/ui/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EntryScreen extends StatelessWidget {
  const EntryScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalDataSource>(
      builder: (ctx, ds, ch) {
        if (Injection.localDataSource.userId == null) return LoginScreen();
        return FutureBuilder(
          builder: (_, snap) {
            if (snap.connectionState != ConnectionState.done) return Scaffold();
            return HomeScreen();
          },
          future: Future.doWhile(() async {
            if (Injection.repository.loggedInUser() == null) {
              await Future.delayed(Duration(milliseconds: 500));
              return true;
            }
            return false;
          }),
        );
      },
    );
  }
}
