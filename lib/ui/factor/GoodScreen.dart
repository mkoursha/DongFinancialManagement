import 'package:dong/data/entities.dart';
import 'package:dong/ui/shared/ConsumerCard.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class GoodScreen extends StatefulWidget {
  final List<User> users;

  GoodScreen(this.users);

  @override
  _GoodScreenState createState() => _GoodScreenState();
}

class _GoodScreenState extends State<GoodScreen> {
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

  String name = '';
  double unitPrice = 0;
  double number = 0;
  List<Consumer> consumers = [];

  @override
  void initState() {
    super.initState();
    consumers.addAll(widget.users
        .map<Consumer>((e) => Consumer(id: null, user: e, number: 0.0)));
  }

  @override
  Widget build(BuildContext context) {
    int _itr = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Good"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: "Good Name:"),
              onChanged: (val) => name = val,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Unit Price:"),
              onChanged: (val) => unitPrice = double.tryParse(val) ?? 0.0,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Number:"),
              onChanged: (val) => number = double.tryParse(val) ?? 0.0,
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text("Consumers:"),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 8.0),
              decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.users.map((user) {
                  return ConsumerCard(
                      user.name,
                      colors[_itr++],
                      consumers
                          .firstWhere((element) => element.user.id == user.id));
                }).toList(),
              ),
            ),
            Center(
              child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () {
                    //add good to specific factor
                    if (consumers
                            .reduce((value, element) =>
                                Consumer(number: value.number + element.number))
                            .number >
                        number) {
                      Toast.show("total consumed is greater than good number ",
                          context);
                      return;
                    }
                    if (name == null ||
                        name == "" ||
                        unitPrice == null ||
                        number == null ||
                        consumers
                                .reduce((value, element) => Consumer(
                                    number: value.number + element.number))
                                .number ==
                            0.0) {
                      Toast.show("Please fill all inputs", context);
                      return;
                    }
                    Navigator.pop(
                      context,
                      Good(null, name, unitPrice, number, consumers),
                    );
                  },
                  child: Text("Add")),
            ),
          ],
        ),
      ),
    );
  }
}
