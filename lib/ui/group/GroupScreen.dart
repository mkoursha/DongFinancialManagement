import 'package:dong/data/entities.dart';
import 'package:dong/di.dart';
import 'package:dong/ui/chatbox/ChatBoxScreen.dart';
import 'package:dong/ui/factor/FactorScreen.dart';
import 'package:dong/ui/group/GroupSettingScreen.dart';
import 'package:dong/ui/shared/FactorCard.dart';
import 'package:dong/ui/state/groups_state.dart';
import 'package:flutter/material.dart';
import 'package:dong/ui/calculation/CalculatinScreen.dart';
import 'package:provider/provider.dart' as pv;
import 'package:toast/toast.dart';

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
  String groupId;

  GroupScreen(this.groupId);
}

class _GroupScreenState extends State<GroupScreen> {
  List<Color> colors = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.lime,
    Colors.black,
    Colors.purple,
    Colors.orange,
    Colors.pink
  ];

  @override
  Widget build(BuildContext context) {
    return pv.ChangeNotifierProvider.value(
      value: Injection.groupsState,
      child: pv.Consumer<GroupsState>(
        builder: (ctx, snap, ch) {
          Group group = snap.groups.firstWhere(
              (element) => element.id == widget.groupId,
              orElse: () => null);
          return Scaffold(
            appBar: AppBar(
              title: Text(group.name),
              actions: [
                FlatButton.icon(
                  icon: Icon(
                    Icons.chat,
                    color: Colors.white,
                  ),
                  label: Text(
                    "ChatBox",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatBoxScreen()),
                    );
                  },
                ),
                if (Injection.localDataSource.userId == group.creator.id)
                  IconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  GroupSettingScreen(group.id)),
                        );
                      })
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Text("Factors:"),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: group.factors.isNotEmpty
                          ? group.factors
                              .map((factor) =>
                                  FactorCard(factor, group, colors[0]))
                              .toList()
                          : [
                              Center(
                                child: Text("Nothing"),
                              )
                            ],
                    ),
                  ),
                  Center(
                    child: FlatButton(
                      color: Theme.of(context).primaryColor,
                      child: Text("Calculation"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalculationScreen(
                                    group: group,
                                  )),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                backgroundColor: Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FactorScreen(group.id)),
                  );
                },
                icon: Icon(Icons.add_box_outlined),
                label: Text("New Factor")),
          );
        },
      ),
    );
  }
}
