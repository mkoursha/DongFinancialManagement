import 'package:dong/data/entities.dart';
import 'package:dong/di.dart';
import 'package:dong/ui/shared/GoodCard.dart';
import 'package:dong/ui/state/groups_state.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:toast/toast.dart';

import 'GoodScreen.dart';
import 'package:provider/provider.dart' as pv;

class FactorScreen extends StatefulWidget {
  final String groupId;

  FactorScreen(this.groupId);
  @override
  _FactorScreenState createState() => _FactorScreenState();
}

class _FactorScreenState extends State<FactorScreen> {
  User buyer;
  List<Good> goods = [];
  @override
  Widget build(BuildContext context) {
    return pv.ChangeNotifierProvider.value(
      value: Injection.groupsState,
      child: pv.Consumer<GroupsState>(
        builder: (_, snap, __) {
          Group group = snap.groups.firstWhere(
              (element) => element.id == widget.groupId,
              orElse: () => null);
          if (group == null) return Container();
          buyer = buyer ?? group.creator;

          return Scaffold(
              appBar: AppBar(
                title: Text("Factor"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    SelectFormField(
                      textAlign: TextAlign.center,
                      initialValue: buyer.id,
                      labelText: 'Buyer:',
                      items: (group.subscribers + [group.creator])
                          .map((e) => {
                                "value": e.id,
                                "label": e.name,
                              })
                          .toList(),
                      onChanged: (val) {
                        buyer = (group.subscribers + [group.creator])
                            .firstWhere((element) => element.id == val);
                      },
                      onSaved: (val) => print(val),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text("Goods:"),
                    ),
                    Container(
                      padding: EdgeInsets.all(5.0),
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: goods.map((good) {
                          return GoodCard(good.name);
                        }).toList(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: FlatButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: () async {
                              String message;
                              if (goods.isEmpty)
                                message = "You need to add goods";
                              if (message == null) {
                                Toast.show(
                                  "Please wait ....",
                                  context,
                                  duration: 5,
                                );
                                var result =
                                    await Injection.createFactor.createFactor(
                                  buyerUserId: buyer.id,
                                  goods: goods,
                                  groupId: widget.groupId,
                                  description: "",
                                  date: DateTime.now(),
                                );
                                if (result != null) message = result.message;
                              }
                              if (message != null)
                                Toast.show(message, context);
                              else {
                                Toast.show(
                                  "Factor submitted.",
                                  context,
                                  duration: 1,
                                );
                                Toast.show(
                                  "Syncing data ....",
                                  context,
                                  duration: 5,
                                );
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text("Add")),
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton.extended(
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () async {
                    var result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              GoodScreen(group.subscribers + [group.creator])),
                    );
                    if (result != null)
                      setState(() {
                        goods.add(result);
                      });
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add Good")));
        },
      ),
    );
  }
}
