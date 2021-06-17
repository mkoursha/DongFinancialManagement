import 'package:dong/data/entities.dart';
import 'package:dong/di.dart';
import 'package:dong/ui/base.dart';
import 'package:dong/ui/group/CreateGroupScreen.dart';
import 'package:dong/ui/group/GroupScreen.dart';
import 'package:dong/ui/home/homeViewModel.dart';
import 'package:dong/ui/login/loginscreen.dart';
import 'package:dong/ui/shared/CustomDrawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var viewModel = HomeViewModel();
String username = '';
User user;

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    viewModel.showUserInfo((User info) {
      user = info;
      username = info.getName();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("$username"),
            )
          ],
        ),
        drawer: CustomDrawer(user),
        body: StreamBuilder<List<Group>>(
          stream: Injection.getGroups.groupsStream(),
          builder: (context, snapshot) {
            List<Group> groups = snapshot.data;
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.blue,
                ),
              );
            if (groups == null || groups.isEmpty)
              return Center(
                child: Text("No Groups Yet!"),
              );
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView(
                  children: groups
                      .map((group) => ListTile(
                            title: Text(group.name),
                            subtitle: Text("Creator : ${group.creator.name}"),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GroupScreen(group.id),
                                ),
                              );
                            },
                          ))
                      .toList()),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateGroupScreen()),
              );
            },
            icon: Icon(Icons.group_add),
            label: Text("New Group")),
      ),
    );
  }
}
