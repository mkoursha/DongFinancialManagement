import 'package:dong/data/entities.dart';
import 'package:dong/di.dart';
import 'package:dong/ui/state/groups_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as pv;
import 'package:toast/toast.dart';

import 'AddSubScreen.dart';

class GroupSettingScreen extends StatefulWidget {
  @override
  _GroupSettingScreenState createState() => _GroupSettingScreenState();
  String groupId;

  GroupSettingScreen(this.groupId);
}

class _GroupSettingScreenState extends State<GroupSettingScreen> {
  @override
  Widget build(BuildContext context) {
    return pv.ChangeNotifierProvider.value(
        value: Injection.groupsState,
        child: pv.Consumer<GroupsState>(
          builder: (_, snap, __) {
            Group group = snap.groups.firstWhere(
                (element) => element.id == widget.groupId,
                orElse: () => null);
            return Container(
              child: Scaffold(
                floatingActionButton: FloatingActionButton.extended(
                    backgroundColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddSubScreen(group)),
                      );
                    },
                    icon: Icon(Icons.person_add),
                    label: Text("Add Subscriber")),
                appBar: AppBar(
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete_forever_rounded),
                    )
                  ],
                  title: Text("Group Settings"),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 8.0,
                      ),
                      Center(
                        child: Text(
                          "${group.name}",
                          style: TextStyle(fontSize: 32.0),
                        ),
                      ),
                      Center(
                        child: Text(
                          "Creator : ${group.creator.name}",
                        ),
                      ),
                      SizedBox(
                        height: 18.0,
                      ),
                      Text("Members:"),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: group.subscribers.isNotEmpty
                              ? group.subscribers
                                  .map(
                                    (user) => ListTile(
                                      title: Text(user.name),
                                      subtitle: Text(user.id),
                                      trailing: IconButton(
                                        icon: Icon(Icons.clear),
                                        onPressed: () {
                                          Injection.removeSubscriber
                                              .removeSubscriber(
                                                  user.id, widget.groupId)
                                              .then((value) {
                                            if (value == null) {
                                              Toast.show(
                                                "Subscriber removed. Syncing ....",
                                                context,
                                                duration: 3,
                                              );
                                            } else {
                                              Toast.show(
                                                value.message,
                                                context,
                                              );
                                            }
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                  .toList()
                              : [
                                  Center(
                                    child: Text("NoOne Else"),
                                  )
                                ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
