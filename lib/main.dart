import 'package:dong/backend/repository/cache/local_datasource.dart';
import 'package:dong/di.dart';
import 'package:dong/ui/entry_screen.dart';
import 'package:dong/ui/group/GroupScreen.dart';
import 'package:dong/ui/home/homescreen.dart';
import 'package:dong/ui/login/loginscreen.dart';
import 'package:dong/ui/state/groups_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bancher',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          buttonColor: Color(0xff7BBA3C),
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xff1565c1),
        ),
        canvasColor: Color(0xffFFFFFF),
        accentColor: Color(0xffFD2323),
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Injection.groupsState),
          ChangeNotifierProvider.value(value: Injection.localDataSource)
        ],
        builder: (ctx, _) => EntryScreen(),
      ),
    );
  }
}
