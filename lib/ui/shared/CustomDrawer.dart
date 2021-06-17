import 'dart:io';

import 'package:dong/backend/exposed/calculate/calculate_dong.dart';
import 'package:dong/data/entities.dart';
import 'package:dong/di.dart';
import 'package:dong/ui/about/about.dart';
import 'package:dong/ui/common/cadu_screen.dart';
import 'package:dong/ui/invite/Invite.dart';
import 'package:flutter/material.dart';
import 'package:dong/ui/home/homescreen.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
  User user;

  CustomDrawer(this.user);
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.user.name}",
                  style: TextStyle(fontSize: 18),
                ),
                SelectableText("id: ${widget.user.id}")
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet_outlined),
            title: Text("Wallet"),
            onTap: () {
              //show wallwetScreen
            },
          ),
          ListTile(
            leading: Icon(Icons.calculate_outlined),
            title: Text("Calculate Accounts"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => CaduScreen(
                        cadu: CalculateDong(
                                groups: Injection.getGroups.currentGroups)
                            .show(Injection.localDataSource.userId),
                      )));
            },
          ),
          ListTile(
            leading: Icon(Icons.message_outlined),
            title: Text("Inviting with SMS"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Invite()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text("Sign Out"),
            onTap: () {
              Injection.localDataSource.removeUserId();
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text("About Us"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUs()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app_outlined),
            title: Text("Exit"),
            onTap: () {
              //todo while exiting
              Future.delayed(const Duration(milliseconds: 500), () {
                exit(0);
              });
            },
          ),
        ],
      ),
    );
  }
}
